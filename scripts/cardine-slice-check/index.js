import { spawn } from "node:child_process";
import { randomUUID } from "node:crypto";

const name = "cardine-slice-check";
const KNOWN_EMPTY = "make check controleert nog geen app";
const steers = new WeakMap();

function run(cwd) {
  return new Promise((resolve) => {
    const child = spawn("make", ["check"], {
      cwd,
      env: process.env,
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
      const cwd = agent.session?.header?.cwd;
      if (typeof cwd !== "string" || cwd.length === 0) return;
      const result = await run(cwd);
      if (result.code === 0) return;
      if (result.stderr.includes(KNOWN_EMPTY)) return;
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
