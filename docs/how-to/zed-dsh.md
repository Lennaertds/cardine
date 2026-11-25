# How-to — Zed + DeepSeek Harness

> **Role:** turn on the lab path: upstream Zed, pinned `dsh --profile acp`, API key locally.
> **Not here:** the decision ([ADR 0003](../decisions/0003-the-agent-loop-is-upstream-deepseek-harness-pinned-as-a-dsh-profile-acp-without-fork.md), [ADR 0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md)); the other agent paths ([PRODUCT.md](../product/PRODUCT.md)).

## Quick path (new machine)

On a fresh Arch Linux / Hyprland machine one command in this repo suffices:

```bash
make install-lab
```

The script in `packages/lab/install-lab.sh`:

1. **Arch dependencies** via `sudo pacman -S --needed --noconfirm` (only when sudo is available):
   - `zed` or `zeditor` — if `zeditor` is not on PATH
   - `bubblewrap` — if `bwrap` is not on PATH
   - `nodejs` + `npm` — if node is missing or < 24.9
   - `uv` (Python package manager) — if uv is missing
   - `jq` — if jq is missing
   - `base-devel` + `go` — if the build tools are missing (needed for Zoekt/SCIP)
2. **Node ≥ 24.9** — if pacman has an older version, the script tries `fnm`, `nvm` or `n` when installed.
3. **jarvis-server** — via `uv tool install --python 3.13 jarvis-mcp`, then `setup.sh --only zoekt --only scip` for Zoekt/SCIP (builds Rust and Go binaries). If `setup.sh` is missing from the package, the script builds Zoekt, SCIP and scip-python itself into `~/.jarvis/bin`.
4. **DeepSeek Harness** (`@deepseek-ai/dsh@0.2.2-rc.1`) via npm when that version is not present yet.
5. **DSH ACP profile** in `~/.dsh/profiles/acp/cordis.patch.yml` with the DeepInfra provider, jarvis MCP, sandbox policy and slice check.
6. **Zed configuration** in `~/.config/zed/settings.json` (JSONC-safe, keeps existing settings).
7. **Credentials** in `~/.dsh/.env` with `DEEPSEEK_API_KEY=` (chmod 600) — never overwrites an existing key.
8. Ends with a clear note that all that remains is filling in your DeepInfra API key.

**Idempotent:** a second run skips everything already present and up to date. Missing tools are installed only when sudo is available; in a sandbox/container without sudo you get clear instructions for a manual install.

## Manual installation

### Pin

| Piece | Version on this machine |
|------|------------------------|
| Zed | `zeditor` 1.28.1 from the distro (`/usr/bin/zeditor`) |
| DeepSeek Harness | `@deepseek-ai/dsh@0.2.2-rc.1` |
| Node | ≥ 24.9, here v26 |

### Installing

```bash
npm install -g --prefix "$HOME/.local" \
  --allow-scripts='@deepseek-ai/dsh-subprocess-local,koffi,node-pty,@google/genai,protobufjs' \
  @deepseek-ai/dsh@0.2.2-rc.1
"$HOME/.local/bin/dsh" --version
```

With npm 11+ (Node 26) postinstall scripts are blocked unless they are allowed
explicitly; without `--allow-scripts` the native modules (`koffi`, `node-pty`)
stay unbuilt and `dsh` fails at startup.

Zed starts the absolute path `~/.local/bin/dsh`, so the desktop does not need the shell PATH.

### API-key

The variable is called `DEEPSEEK_API_KEY`. It belongs in `~/.dsh/.env`, not in Zed settings and not in git.

```bash
mkdir -p ~/.dsh
touch ~/.dsh/.env
chmod 600 ~/.dsh/.env
```

Put one line in it: `DEEPSEEK_API_KEY=` followed by your DeepInfra API key. A project `.env` wins over this file once Zed opens that project as its working directory. The stored `~/.dsh/.credentials.yaml` wins over both. An empty value does not belong in that store file.

### DeepInfra provider

The ACP profile in `~/.dsh/profiles/acp/cordis.patch.yml` configures DeepInfra as the LLM provider:

```yaml
llm-pi-ai:
  -
    provider: deepinfra
    baseURL: "https://api.deepinfra.com/v1/openai"
    api: openai-completions
    apiKeyEnv: DEEPSEEK_API_KEY
    model: deepseek-ai/DeepSeek-V4-Flash

acp:
  agent-default-model:
    provider: deepinfra
    model: deepseek-ai/DeepSeek-V4-Flash
```

### Zed 1.28+ — `env.PATH` for agent_servers

In a graphical Wayland/Hyprland session `~/.local/bin` and `~/.jarvis/bin` are not
on Zed's `PATH` by default. Add `PATH` explicitly under `env`:

```json
"DeepSeek Harness": {
  "type": "custom",
  "command": "dsh",
  "args": ["--profile", "acp"],
  "env": {
    "PATH": "$HOME/.jarvis/bin:$HOME/.local/bin:/usr/bin:/bin"
  }
}
```

Zed picks up that change itself. In the Agent panel start a thread via
**...** → **New DeepSeek Harness Thread** (Zed 1.28+), or by selecting
**DeepSeek Harness** in the agent picker.

> **Note:** the `env.PATH` field is necessary because a graphical session does
> not pass `~/.local/bin` and `~/.jarvis/bin` into a child process's `PATH`.
> Without it, `jarvis-server` cannot find the Zoekt/SCIP binaries.

The bundled ACP profile opens a session on `deepseek-ai/DeepSeek-V4-Flash` via DeepInfra. [ADR 0008](../decisions/0008-the-coding-model-is-deepseek-flash-and-claude-is-the-second-provider.md) names `deepseek-flash`; the exact model id on DeepInfra is `deepseek-ai/DeepSeek-V4-Flash`.

## jarvis

The ACP profile mounts jarvis as MCP ([ADR 0006](../decisions/0006-the-agent-searches-via-jarvis-as-mcp-zed-search-and-lsp-stay-with-the-editor.md)). The plugin is `@deepseek-ai/dsh-mcp-client`, as an `insert` in `cordis.patch.yml`, not as a change to an existing row. The command is the absolute path `~/.local/bin/jarvis-server`. `PATH` puts `~/.jarvis/bin` in front, because a desktop Zed does not have that directory.

The model sees the tools as `mcp__jarvis__searchCode`, `mcp__jarvis__goToDefinition`, `mcp__jarvis__findReferences` and `mcp__jarvis__getIndexStatus`. A thread that was already open before the insert does not see them. Start a new **DeepSeek Harness** thread.

## Allowlist and bwrap

New threads run with `workspace-write` (the repo) and `approval: never` ([ADR 0017](../decisions/0017-the-agent-writes-in-the-cage-and-the-fs-write-tools-are-off.md)). There is no dialogue. `write`, `edit` and `apply_patch` are off; writing happens through the shell in the cage. A path outside the repo is not mounted. `DSH_PERMISSION_MODE=danger-full-access` bypasses that boundary; the lab profile does not set that variable.

The shell goes through `packages/lab/cardine-bwrap`. It binds the workspace, so a write lands on the host immediately, and runs in a user namespace. The network stays open. `~/.ssh`, `~/.secrets` and `~/.dsh/.env` are not visible ([ADR 0007](../decisions/0007-tool-approval-is-a-workspace-allowlist-and-the-shell-runs-under-bwrap.md)).

## make check

`packages/lab/cardine-slice-check` listens on `agent/turn-stopping`. A red `make check` sends the agent back, at most twice. The known stop "no app, CHECK empty" does not ([ADR 0001](../decisions/0001-runtime-stack-deliberately-deferred-until-an-explicit-pi-or-ts-choice.md)). A thread from before this insert does not see the hook.

## Verification

`dsh --profile acp` must exit with code 0 as soon as stdin closes. A fresh start that receives `initialize` and `session/new` makes jarvis log a `ListToolsRequest`. `searchCode` on `Project-Understanding` hits this repo. A dirty or just-written sentence is not in it until `jarvis index <path> --no-semantic` runs again.

> **Tip:** use `jarvis index "$(pwd)" --no-semantic` to index this repo.
> `--no-semantic` prevents jarvis from downloading a multi-GB semantic model weight.
> The lexical Zoekt index (searchCode) is then available to the agent.