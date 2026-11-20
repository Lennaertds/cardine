# Status — Jarvis + DSH op laptop checken

> **Rol:** Checklist om te verifiëren of `jarvis-server` (MCP-indexing) en `dsh` (DeepSeek Harness, ACP-profiel) correct geïnstalleerd en geconfigureerd zijn op een verse (of bijgewerkte) machine.
>
> **Gebruik:** Voer de commando's een voor een uit op de doel-machine. Bestand is copy-paste-klaar.

## 1. Basischecks — staan dsh en jarvis op PATH?

```bash
# DSH (DeepSeek Harness)
which dsh && dsh --version

# Als niet op PATH, check expliciet:
ls -la ~/.local/bin/dsh

# jarvis-server
which jarvis-server
# of expliciet:
ls -la ~/.local/bin/jarvis-server

# jarvis CLI
which jarvis
```

> **Verwacht:** `dsh` → versie `0.2.2-rc.1` (of nieuwer).  
> `jarvis-server` en `jarvis` in `~/.local/bin`.

---

## 2. Zoekt + SCIP binaries

```bash
# Zoekt (code search index)
ls ~/.jarvis/bin/zoekt-git-index ~/.jarvis/bin/zoekt-webserver

# SCIP (code intelligence index)
ls ~/.jarvis/bin/scip ~/.jarvis/bin/scip-python
```

> **Verwacht:** Bestanden bestaan. Als ze ontbreken → `install-lab.sh` heeft de build-stap niet doorlopen (of is nooit gerund).

---

## 3. DSH ACP-profiel

```bash
ls -la ~/.dsh/profiles/acp/cordis.patch.yml
```

> **Verwacht:** Bestand bestaat. Bevat DeepInfra-provider, jarvis MCP-insert, sandbox-beleid (workspace-write + bwrap) en slice-check.

---

## 4. API-key placeholder

```bash
ls -la ~/.dsh/.env
cat ~/.dsh/.env
```

> **Let op:** `.env` nooit in git. De key moet er echt in staan (`DEEPSEEK_API_KEY=sk-...`). Het script `install-lab.sh` overschrijft een bestaande key niet.

---

## 5. Zed-configuratie

```bash
cat ~/.config/zed/settings.json | grep -A 10 "DeepSeek Harness"
```

> **Verwacht:** Een `"DeepSeek Harness"` block met:
> - `"command": "/home/ventje/.local/bin/dsh"`
> - `"args": ["--profile", "acp"]`
> - `"env"` met `PATH` die `~/.jarvis/bin` en `~/.local/bin` bevat

---

## 6. Node-versie

```bash
node --version
```

> **Minimum:** `v24.9.0` (v26 op desktop).

---

## 7. Is de repo al geïndexeerd?

```bash
jarvis get-index-status "$(pwd)"
```

> Als er geen index is, maak er een met:
> ```bash
> jarvis index "$(pwd)" --no-semantic
> ```
> (duurt even — bouwt de Zoekt-index)

---

## 8. Snelle integratietest — start DSH even op

```bash
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | dsh --profile acp 2>&1 | head -20
```

> **Verwacht:** Initialize-resultaat + `session/new`. Als jarvis MCP goed mount, zie je ook `ListToolsRequest`.

---

## Overzicht: wat hoort er te staan

| Onderdeel | Pad | Doel |
|-----------|-----|------|
| `dsh` | `~/.local/bin/dsh` | DeepSeek Harness binary (v0.2.2-rc.1) |
| `jarvis-server` | `~/.local/bin/jarvis-server` | MCP-server voor indexing |
| `jarvis` | `~/.local/bin/jarvis` | CLI voor indexing/status |
| Zoekt binaries | `~/.jarvis/bin/zoekt-*` | Code search engine |
| SCIP binary | `~/.jarvis/bin/scip` | Code intelligence indexer |
| DSH profiel | `~/.dsh/profiles/acp/cordis.patch.yml` | Provider + MCP + danger-full-access + approval auto |
| API-key | `~/.dsh/.env` | `DEEPSEEK_API_KEY=sk-...` |
| Zed settings | `~/.config/zed/settings.json` | Start DSH met `--profile acp` |

## Herstel

Alles in één keer (idempotent) opnieuw installeren:

```bash
cd /pad/naar/cardine
make install-lab
```

Of direct:

```bash
bash packages/lab/install-lab.sh
```

Het script slaat over wat al goed staat. Na afloop checken of `~/.dsh/.env` de API-key bevat.
