// Tests for cardine-workspace-guard: run with `node --test`.
// Covers the allowlist: everything outside the workspace is refused, secrets
// inside the workspace stay closed, *.example and normal project paths go
// through, and `..`/symlinks/new paths do not bypass the boundary.

import { test } from "node:test";
import assert from "node:assert/strict";
import { mkdtemp, mkdir, writeFile, symlink, realpath } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { apply, WORKSPACE_GUARD_DENIED } from "./index.js";

// A temporary HOME with the well-known secret folders. The guard no longer needs
// it for the boundary — that is the workspace — but the outcome must be the same
// inside and outside HOME, so this proves that "under HOME" is no exception.
const home = await mkdtemp(join(tmpdir(), "guard-home-"));
await mkdir(join(home, ".secrets", "repo"), { recursive: true });
await writeFile(join(home, ".secrets", "repo", ".env"), "SECRET=1\n");
await mkdir(join(home, ".dsh"), { recursive: true });
await writeFile(join(home, ".dsh", ".env"), "KEY=1\n");

const repo = await realpath(await mkdtemp(join(tmpdir(), "guard-repo-")));
await writeFile(join(repo, ".env"), "A=1\n");
await writeFile(join(repo, ".env.example"), "A=\n");
await writeFile(join(repo, ".env.production"), "A=prod\n");
await mkdir(join(repo, "apps", "api"), { recursive: true });
await writeFile(join(repo, "apps", "api", ".env.local"), "A=local\n");
await writeFile(join(repo, "key.pem"), "KEY\n");
await writeFile(join(repo, "readme.txt"), "ok\n");
// A symlink inside the repo that points outwards: the guard follows it.
await symlink(join(home, ".secrets"), join(repo, "link-out"));

// The suites below prove the boundary through the session cwd. A
// CARDINE_WORKSPACE in the environment must not override that cwd (Caddie,
// 2026-11-23). The variable is still removed from the environment per suite,
// so a leftover pin cannot colour the cwd suites after all.
function withEnvOff(body) {
  return async () => {
    const previous = process.env.CARDINE_WORKSPACE;
    delete process.env.CARDINE_WORKSPACE;
    try {
      await body();
    } finally {
      if (previous === undefined) delete process.env.CARDINE_WORKSPACE;
      else process.env.CARDINE_WORKSPACE = previous;
    }
  };
}

// Mini-Cordis: vangt de listener op en laat ons er mee spelen.
function harness(workspace) {
  let listener;
  const ctx = {
    effect: (fn) => {
      fn().next();
    },
    on: (event, fn) => {
      if (event === "tools/pre-execute") listener = fn;
      return () => {};
    },
  };
  apply(ctx);
  return async (toolName, args) => {
    const session = workspace ? { cwd: workspace } : {};
    const exec = { name: toolName, arguments: args, agent: { session } };
    return listener(exec, async () => ({ kind: "allow" }));
  };
}

const run = harness(repo);

const fsArgs = (tool, path) =>
  tool === "grep" || tool === "glob" ? { pattern: "x", path } : { file_path: path };

test("refuses every path outside the workspace, even when it is not secret", withEnvOff(async () => {
  const outside = [
    "/etc/passwd",
    "/etc/shadow",
    join(home, ".dsh", ".env"),
    join(home, ".ssh", "known_hosts"),
    join(home, ".secrets", "repo", ".env"),
    "/tmp/anything.txt",
    join(repo, "..", "naast-de-repo.txt"),
  ];
  for (const path of outside) {
    const decision = await run("read", fsArgs("read", path));
    assert.equal(decision.kind, "deny", `${path} must be refused`);
    assert.equal(decision.info.code, WORKSPACE_GUARD_DENIED);
    assert.match(decision.reason, /outside the workspace/);
  }
}));

test("refuses a symlink that points outwards", withEnvOff(async () => {
  const decision = await run("read", fsArgs("read", join(repo, "link-out", ".env")));
  assert.equal(decision.kind, "deny");
  assert.match(decision.reason, /outside the workspace/);
}));

test("still refuses .env/keys inside the workspace", withEnvOff(async () => {
  const secrets = [
    ".env",
    join(repo, ".env"),
    ".env.production",
    join(repo, "apps/api/.env.local"),
    join(repo, "key.pem"),
    "apps/../.env",
    join(repo, "apps", "new", ".env"), // does not exist yet
  ];
  for (const path of secrets) {
    const decision = await run("read", fsArgs("read", path));
    assert.equal(decision.kind, "deny", `${path} must be refused`);
    assert.equal(decision.info.code, WORKSPACE_GUARD_DENIED);
  }
}));

test("lets normal project paths and *.example through", withEnvOff(async () => {
  for (const path of [
    join(repo, "readme.txt"),
    ".env.example",
    join(repo, "apps/api/x.ts"),
    "new/file.md",
    ".",
    join(repo, "docs"),
  ]) {
    const decision = await run("read", fsArgs("read", path));
    assert.equal(decision.kind, "allow", `${path} must be allowed`);
  }
}));

test("the open session beats CARDINE_WORKSPACE", async () => {
  const previous = process.env.CARDINE_WORKSPACE;
  const pinned = await realpath(await mkdtemp(join(tmpdir(), "guard-pin-")));
  await writeFile(join(pinned, "readme.txt"), "pin\n");
  process.env.CARDINE_WORKSPACE = pinned;
  try {
    const allowed = await run("read", fsArgs("read", join(repo, "readme.txt")));
    assert.equal(allowed.kind, "allow");
    const denied = await run("read", fsArgs("read", join(pinned, "readme.txt")));
    assert.equal(denied.kind, "deny");
    assert.match(denied.reason, /outside the workspace/);
  } finally {
    if (previous === undefined) delete process.env.CARDINE_WORKSPACE;
    else process.env.CARDINE_WORKSPACE = previous;
  }
});

test("without a session cwd CARDINE_WORKSPACE applies", async () => {
  const previous = process.env.CARDINE_WORKSPACE;
  process.env.CARDINE_WORKSPACE = repo;
  try {
    const unscoped = harness(null);
    const allowed = await unscoped("read", fsArgs("read", join(repo, "readme.txt")));
    assert.equal(allowed.kind, "allow");
    const denied = await unscoped("read", fsArgs("read", "/etc/hostname"));
    assert.equal(denied.kind, "deny");
    assert.match(denied.reason, /outside the workspace/);
  } finally {
    if (previous === undefined) delete process.env.CARDINE_WORKSPACE;
    else process.env.CARDINE_WORKSPACE = previous;
  }
});

test("a CARDINE_WORKSPACE in the environment does not break the cwd suites", async () => {
  // Regressie 2026-11-23: in de DSH-shell stond CARDINE_WORKSPACE, waardoor
  // de tests die de sessie-cwd bewijzen /tmp/guard-repo-* als "buiten de
  // workspace" weigerden. withEnvOff haalt de variabele per suite weg.
  const previous = process.env.CARDINE_WORKSPACE;
  process.env.CARDINE_WORKSPACE = "/does/not/exist";
  try {
    await withEnvOff(async () => {
      const decision = await run("read", fsArgs("read", join(repo, "readme.txt")));
      assert.equal(decision.kind, "allow");
    })();
  } finally {
    if (previous === undefined) delete process.env.CARDINE_WORKSPACE;
    else process.env.CARDINE_WORKSPACE = previous;
  }
});

test("write/edit are bounded too (for profiles that mount them)", withEnvOff(async () => {
  const ok = await run("write", { file_path: join(repo, "apps", "x.ts"), content: "x" });
  assert.equal(ok.kind, "allow");
  const bad = await run("write", { file_path: "/etc/hosts", content: "x" });
  assert.equal(bad.kind, "deny");
  const badEdit = await run("edit", { file_path: join(home, "notes.md") });
  assert.equal(badEdit.kind, "deny");
}));
