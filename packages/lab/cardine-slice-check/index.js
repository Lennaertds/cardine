import { spawn } from "node:child_process";
import { existsSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { randomUUID } from "node:crypto";

const name = "cardine-slice-check";
const steers = new WeakMap();

// De cardine-repo is ../../.. t.o.v. dit bestand (packages/lab/cardine-slice-check/index.js → cardine/)
const CARDINE_ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "../../..");

function findMakefile(dir) {
  while (dir !== "/") {
    if (existsSync(resolve(dir, "Makefile"))) return dir;
    const parent = resolve(dir, "..");
    if (parent === dir) return null;
    dir = parent;
  }
  return null;
}

function run(cwd) {
  return new Promise((resolve) => {
    const child = spawn("make", ["check"], {
      cwd,
      env: { ...process.env, PATH: process.env.PATH },
    });
    let stderr = "";
    child.stderr.on("data", (chunk) => {
      stderr += chunk.toString();
      if (stderr.length > 4000) stderr = stderr.slice(-4000);
    });
    child.on("error", (error) => resolve({ code: 127, stderr: error.message }));
    child.on("close", (code) => resolve({ code: code ?? 1, stderr }));
  });
}

function apply(ctx) {
  ctx.on("agent/turn-stopping", async ({ agent }) => {
    try {
      // Bepaal CWD: agent's cwd, of fallback naar cardine root
      let cwd = agent.session?.header?.cwd;
      if (typeof cwd !== "string" || cwd.length === 0) cwd = CARDINE_ROOT;

      // Zoek naar een Makefile — als de agent in een niet-cardine dir zit,
      // gebruik dan de cardine root.
      const mkDir = findMakefile(cwd);
      if (!mkDir) cwd = CARDINE_ROOT;
      else cwd = mkDir;

      const result = await run(cwd);
      if (result.code === 0) return;

      const count = steers.get(agent) ?? 0;
      if (count >= 2) return;
      steers.set(agent, count + 1);
      const tail = result.stderr.trim().split("\n").slice(-20).join("\n");
      agent.steer({
        role: "user",
        id: randomUUID(),
        content: [{
          type: "text",
          text: `make check is rood (code ${result.code}). De slice sluit niet. Fix, of zet de slice terug.\n${tail}`,
        }],
        source: { kind: "user" },
      });
    } catch (error) {
      console.error(`cardine-slice-check: ${error instanceof Error ? error.message : String(error)}`);
    }
  });
}

export { apply, name };
