// Tests voor cardine-workspace-guard: draai met `node --test`.
// Deckt de allowlist: alles buiten de workspace wordt geweigerd, geheimen
// binnen de workspace blijven dicht, *.example en gewone projectpaden gaan
// door, en `..`/symlinks/nieuwe paden omzeilen de grens niet.

import { test } from "node:test";
import assert from "node:assert/strict";
import { mkdtemp, mkdir, writeFile, symlink, realpath } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { apply, WORKSPACE_GUARD_DENIED } from "./index.js";

// Een tijdelijke HOME met de bekende secret-mappen; de guard hoeft hem niet
// meer te kennen voor de grens — die is de workspace — maar de uitkomst moet
// ook buiten de workspace geweigerd zijn, dus dit bewijst dat "onder HOME"
// geen uitzondering is.
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
// Een symlink binnen de repo die naar buiten wijst: de guard volgt hem.
await symlink(join(home, ".secrets"), join(repo, "link-out"));

// De suites hieronder bewijzen de grens via de sessie-cwd. Een
// CARDINE_WORKSPACE in de omgeving mag die cwd niet overrulen (Caddie,
// 2026-11-23). De variabele wordt per suite toch uit de omgeving gehaald,
// zodat een achtergebleven pin de cwd-suites niet alsnog kleurt.
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

test("weigert elk pad buiten de workspace, ook als het niet geheim is", withEnvOff(async () => {
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
    assert.equal(decision.kind, "deny", `${path} hoort geweigerd te worden`);
    assert.equal(decision.info.code, WORKSPACE_GUARD_DENIED);
    assert.match(decision.reason, /buiten de workspace/);
  }
}));

test("weigert een symlink die naar buiten wijst", withEnvOff(async () => {
  const decision = await run("read", fsArgs("read", join(repo, "link-out", ".env")));
  assert.equal(decision.kind, "deny");
  assert.match(decision.reason, /buiten de workspace/);
}));

test("weigert binnen de workspace nog steeds .env/keys", withEnvOff(async () => {
  const secrets = [
    ".env",
    join(repo, ".env"),
    ".env.production",
    join(repo, "apps/api/.env.local"),
    join(repo, "key.pem"),
    "apps/../.env",
    join(repo, "apps", "nieuw", ".env"), // bestaat nog niet
  ];
  for (const path of secrets) {
    const decision = await run("read", fsArgs("read", path));
    assert.equal(decision.kind, "deny", `${path} hoort geweigerd te worden`);
    assert.equal(decision.info.code, WORKSPACE_GUARD_DENIED);
  }
}));

test("laat gewone projectpaden en *.example door", withEnvOff(async () => {
  for (const path of [
    join(repo, "readme.txt"),
    ".env.example",
    join(repo, "apps/api/x.ts"),
    "nieuw/bestand.md",
    ".",
    join(repo, "docs"),
  ]) {
    const decision = await run("read", fsArgs("read", path));
    assert.equal(decision.kind, "allow", `${path} hoort toegestaan te worden`);
  }
}));

test("de open sessie wint van CARDINE_WORKSPACE", async () => {
  const previous = process.env.CARDINE_WORKSPACE;
  const pinned = await realpath(await mkdtemp(join(tmpdir(), "guard-pin-")));
  await writeFile(join(pinned, "readme.txt"), "pin\n");
  process.env.CARDINE_WORKSPACE = pinned;
  try {
    const allowed = await run("read", fsArgs("read", join(repo, "readme.txt")));
    assert.equal(allowed.kind, "allow");
    const denied = await run("read", fsArgs("read", join(pinned, "readme.txt")));
    assert.equal(denied.kind, "deny");
    assert.match(denied.reason, /buiten de workspace/);
  } finally {
    if (previous === undefined) delete process.env.CARDINE_WORKSPACE;
    else process.env.CARDINE_WORKSPACE = previous;
  }
});

test("zonder sessie-cwd geldt CARDINE_WORKSPACE", async () => {
  const previous = process.env.CARDINE_WORKSPACE;
  process.env.CARDINE_WORKSPACE = repo;
  try {
    const unscoped = harness(null);
    const allowed = await unscoped("read", fsArgs("read", join(repo, "readme.txt")));
    assert.equal(allowed.kind, "allow");
    const denied = await unscoped("read", fsArgs("read", "/etc/hostname"));
    assert.equal(denied.kind, "deny");
    assert.match(denied.reason, /buiten de workspace/);
  } finally {
    if (previous === undefined) delete process.env.CARDINE_WORKSPACE;
    else process.env.CARDINE_WORKSPACE = previous;
  }
});

test("een CARDINE_WORKSPACE in de omgeving breekt de cwd-suites niet", async () => {
  // Regressie 2026-11-23: in de DSH-shell stond CARDINE_WORKSPACE, waardoor
  // de tests die de sessie-cwd bewijzen /tmp/guard-repo-* als "buiten de
  // workspace" weigerden. withEnvOff haalt de variabele per suite weg.
  const previous = process.env.CARDINE_WORKSPACE;
  process.env.CARDINE_WORKSPACE = "/niet/bestaand";
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

test("write/edit worden ook begrensd (voor profielen die ze mounten)", withEnvOff(async () => {
  const ok = await run("write", { file_path: join(repo, "apps", "x.ts"), content: "x" });
  assert.equal(ok.kind, "allow");
  const bad = await run("write", { file_path: "/etc/hosts", content: "x" });
  assert.equal(bad.kind, "deny");
  const badEdit = await run("edit", { file_path: join(home, "notes.md") });
  assert.equal(badEdit.kind, "deny");
}));
