# Status — checking Jarvis + DSH on a laptop

> **Role:** a checklist to verify that `jarvis-server` (MCP indexing) and `dsh` (DeepSeek Harness, ACP profile) are correctly installed and configured on a fresh (or updated) machine.
>
> **Use:** run the commands one at a time on the target machine. This file is ready to copy-paste.

## 1. Basic checks — are dsh and jarvis on PATH?

```bash
# DSH (DeepSeek Harness)
which dsh && dsh --version

# If not on PATH, check explicitly:
ls -la ~/.local/bin/dsh

# jarvis-server
which jarvis-server
# or explicitly:
ls -la ~/.local/bin/jarvis-server

# jarvis CLI
which jarvis
```

> **Expected:** `dsh` → version `0.2.2-rc.1` (or newer).
> `jarvis-server` and `jarvis` in `~/.local/bin`.

---

## 2. Zoekt + SCIP binaries

```bash
# Zoekt (code search index)
ls ~/.jarvis/bin/zoekt-git-index ~/.jarvis/bin/zoekt-webserver

# SCIP (code intelligence index)
ls ~/.jarvis/bin/scip ~/.jarvis/bin/scip-python
```

> **Expected:** the files exist. If they are missing, `install-lab.sh` did not complete the build step (or was never run).

---

## 3. DSH ACP profile

```bash
ls -la ~/.dsh/profiles/acp/cordis.patch.yml
```

> **Expected:** the file exists. It contains the DeepInfra provider, the jarvis MCP insert, the sandbox policy (workspace-write + bwrap) and the slice check.

---

## 4. API key placeholder

```bash
ls -la ~/.dsh/.env
cat ~/.dsh/.env
```

> **Note:** never put `.env` in git. The key must really be in there (`DEEPSEEK_API_KEY=sk-...`). `install-lab.sh` does not overwrite an existing key.

---

## 5. Zed configuration

```bash
cat ~/.config/zed/settings.json | grep -A 10 "DeepSeek Harness"
```

> **Expected:** a `"DeepSeek Harness"` block with:
> - `"command": "dsh"` or the full path to `dsh`
> - `"args": ["--profile", "acp"]`
> - `"env"` with a `PATH` containing `~/.jarvis/bin` and `~/.local/bin`

---

## 6. Node version

```bash
node --version
```

> **Minimum:** `v24.9.0` (v26 on the desktop).

---

## 7. Is the repo indexed yet?

```bash
jarvis get-index-status "$(pwd)"
```

> If there is no index, create one with:
> ```bash
> jarvis index "$(pwd)" --no-semantic
> ```
> (takes a moment — it builds the Zoekt index)

---

## 8. Quick integration test — start DSH briefly

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | dsh --profile acp 2>&1 | head -20
```

> **Expected:** an initialize result + `session/new`. If jarvis MCP mounts correctly, you also see `ListToolsRequest`.

---

## Overview: what should be there

| Part | Path | Purpose |
|-----------|-----|------|
| `dsh` | `~/.local/bin/dsh` | DeepSeek Harness binary (v0.2.2-rc.1) |
| `jarvis-server` | `~/.local/bin/jarvis-server` | MCP server for indexing |
| `jarvis` | `~/.local/bin/jarvis` | CLI for indexing/status |
| Zoekt binaries | `~/.jarvis/bin/zoekt-*` | Code search engine |
| SCIP binary | `~/.jarvis/bin/scip` | Code intelligence indexer |
| DSH profile | `~/.dsh/profiles/acp/cordis.patch.yml` | Provider + MCP + workspace-write + approval never |
| API key | `~/.dsh/.env` | `DEEPSEEK_API_KEY=sk-...` |
| Zed settings | `~/.config/zed/settings.json` | Starts DSH with `--profile acp` |

## Recovery

Reinstall everything at once (idempotent):

```bash
cd /path/to/cardine
make install-lab
```

Or directly:

```bash
bash packages/lab/install-lab.sh
```

The script skips what is already correct. Afterwards, check that `~/.dsh/.env` holds the API key.
