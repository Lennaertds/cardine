// Tests voor cardine-secrets-guard: draai met `node --test`.
// Deckt: naam-matching, pad-resolutie (. ./ .., symlinks), secret-mappen,
// *.example-uitzondering, en dat normale repo-bestanden gewoon doorgaan.

import { test } from "node:test";
import assert from "node:assert/strict";
import { mkdtemp, mkdir, writeFile, symlink, realpath } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { apply, SECRETS_GUARD_DENIED } from "./index.js";

// Vaste nep-HOME zodat de guard dezelfde mappen kent als in de tests.
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
await symlink(join(home, ".secrets", "repo"), join(repo, "link-out"));

// Mini-Cordis: vangt de listener op en laat ons er mee spelen.
function harness() {
  let listener;
  const ctx = {
    effect: (fn) => {
      const gen = fn();
      gen.next();
    },
    on: (event, fn) => {
      if (event === "tools/pre-execute") listener = fn;
      return () => {};
    },
  };
  apply(Object.assign(ctx, { cwd: repo }));
  return async (toolName, args) => {
    const exec = { name: toolName, arguments: args, agent: { session: { cwd: repo } } };
    return listener(exec, async () => ({ kind: "allow" }));
  };
}

// HOME voor de guard staat op de proces-home; daarom injecteren we via een
// tijdelijke HOME. Node leest os.homedir() bij import → hergebruik de echte
// ~ alleen voor de vaste lijst en test repos-paden met de echte home.
process.env.HOME = home;

const run = harness();

const DENIED = [
  ["read", ".env"],
  ["read", join(repo, ".env")],
  ["read", ".env.production"],
  ["read", join(repo, "apps/api/.env.local")],
  ["read", join(repo, "key.pem")],
  ["write", join(repo, ".env")],
  ["edit", join(repo, ".env")],
  ["read", "./.env"],
  ["read", ".env/../.env"],
  ["read", "apps/../.env"],
  ["glob", "."],              // niet geheim -> mag
];

test("weigert geheime bestanden", async () => {
  for (const [tool, path] of DENIED.slice(0, 10)) {
    const decision = await run(tool, tool === "grep" || tool === "glob" ? { pattern: "x", path } : { file_path: path });
    assert.equal(decision.kind, "deny", `${tool} ${path} hoort geweigerd te worden`);
    assert.equal(decision.info.code, SECRETS_GUARD_DENIED);
    assert.match(decision.reason, /~\/\.secrets/);
  }
});

test("weigert via symlink naar ~/.secrets", async () => {
  const decision = await run("read", { file_path: join(repo, "link-out", ".env") });
  assert.equal(decision.kind, "deny");
});

test("weigert de secrets-centrale en .dsh ook als de naam onschuldig is", async () => {
  for (const path of [join(home, ".secrets", "repo", "notes.txt"), join(home, ".dsh", "x.json"), join(home, ".ssh", "known_hosts")]) {
    const decision = await run("read", { file_path: path });
    assert.equal(decision.kind, "deny", `${path} hoort geweigerd te worden`);
  }
});

test("laat normale bestanden en *.example door", async () => {
  for (const path of [join(repo, "readme.txt"), ".env.example", join(repo, "apps/api/x.ts"), "nieuw/bestand.md"]) {
    const decision = await run("write", { file_path: path });
    assert.equal(decision.kind, "allow", `${path} hoort toegestaan te worden`);
  }
});

test("weigert niet-bestaande .env (write naar een nieuw secret)", async () => {
  const decision = await run("write", { file_path: join(repo, "apps", "nieuw", ".env") });
  assert.equal(decision.kind, "deny");
});
