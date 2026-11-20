# How-to — Zed + DeepSeek Harness

> **Rol:** Het lab-pad aanzetten: upstream Zed, gepinde `dsh --profile acp`, API-key lokaal.
> **Niet hier:** het besluit ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md), [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md)); de andere agent-paden ([PRODUCT.md](../product/PRODUCT.md)).

## Snelle weg (nieuwe machine)

Op een verse Arch Linux / Hyprland-machine volstaat één commando in deze repo:

```bash
make install-lab
```

Het script in `packages/lab/install-lab.sh`:

1. **Arch-dependencies** via `sudo pacman -S --needed --noconfirm` (alleen als sudo beschikbaar is):
   - `zed` of `zeditor` — als `zeditor` niet op PATH staat
   - `bubblewrap` — als `bwrap` niet op PATH staat
   - `nodejs` + `npm` — als node ontbreekt of < 24.9 is
   - `uv` (Python package manager) — als uv ontbreekt
   - `jq` — als jq ontbreekt
   - `base-devel` + `go` — als build-tools ontbreken (nodig voor Zoekt/SCIP)
2. **Node ≥ 24.9** — als pacman een te oude versie heeft, probeert het script via `fnm`, `nvm` of `n` als die geïnstalleerd zijn.
3. **jarvis-server** — via `uv tool install --python 3.13 jarvis-mcp` en daarna `setup.sh --only zoekt --only scip` voor Zoekt/SCIP (bouwt Rust- en Go-binaries).
4. **DeepSeek Harness** (`@deepseek-ai/dsh@0.2.2-rc.1`) via npm als die versie nog niet staat.
5. **DSH ACP-profiel** in `~/.dsh/profiles/acp/cordis.patch.yml` met DeepInfra-provider, jarvis MCP, sandbox-beleid en slice-check.
6. **Zed-configuratie** in `~/.config/zed/settings.json` (JSONC-veilig, behoudt bestaande instellingen).
7. **Credentials** in `~/.dsh/.env` met `DEEPSEEK_API_KEY=` (chmod 600) — overschrijft nooit een bestaande key.
8. Eindigt met een duidelijke melding dat je alleen nog je DeepInfra API-key hoeft in te vullen.

**Idempotent:** een tweede run slaat alles over wat al aanwezig en up-to-date is. Ontbrekende tools worden alleen geïnstalleerd als sudo beschikbaar is; in een sandbox/container zonder sudo krijg je duidelijke instructies voor handmatige installatie.

## Handmatige installatie

### Pin

| Stuk | Versie op deze machine |
|------|------------------------|
| Zed | `zeditor` 1.28.1 uit de distro (`/usr/bin/zeditor`) |
| DeepSeek Harness | `@deepseek-ai/dsh@0.2.2-rc.1` |
| Node | ≥ 24.9, hier v26 |

### Installeren

```bash
npm install -g --prefix "$HOME/.local" @deepseek-ai/dsh@0.2.2-rc.1
"$HOME/.local/bin/dsh" --version
```

Zed start het absolute pad `~/.local/bin/dsh`, zodat het bureaublad de shell-PATH niet nodig heeft.

### API-key

De variabele heet `DEEPSEEK_API_KEY`. Ze hoort in `~/.dsh/.env`, niet in Zed-settings en niet in git.

```bash
mkdir -p ~/.dsh
touch ~/.dsh/.env
chmod 600 ~/.dsh/.env
```

Zet er één regel in: `DEEPSEEK_API_KEY=` gevolgd door je DeepInfra API-key. Een project-`.env` wint van dit bestand zodra Zed dat project als werkmap opent. De opgeslagen store `~/.dsh/.credentials.yaml` wint van allebei. Een lege waarde hoort niet in dat store-bestand.

### DeepInfra-provider

Het ACP-profiel in `~/.dsh/profiles/acp/cordis.patch.yml` configureert DeepInfra als LLM-provider:

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

### Zed 1.28+ — `env.PATH` voor agent_servers

In een grafische Wayland/Hyprland-sessie staat `~/.local/bin` en `~/.jarvis/bin` niet
standaard in het `PATH` van Zed. Voeg daarom `PATH` expliciet toe onder `env`:

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

Zed leest die wijziging zelf. In het Agent-paneel start je een thread via
**...** → **New DeepSeek Harness Thread** (Zed 1.28+) of door **DeepSeek Harness**
te selecteren in de agent-kiezer.

> **Let op:** Het `env.PATH`-veld is noodzakelijk omdat een grafische sessie
> `~/.local/bin` en `~/.jarvis/bin` niet aan het `PATH` van een child-proces
> meegeeft. Zonder deze toevoeging vindt `jarvis-server` de Zoekt/SCIP-binaries
> niet.

Het meegeleverde ACP-profiel opent een sessie op `deepseek-ai/DeepSeek-V4-Flash` via DeepInfra. [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) noemt `deepseek-flash`; het exacte model-id op DeepInfra is `deepseek-ai/DeepSeek-V4-Flash`.

## jarvis

Het ACP-profiel mount jarvis als MCP ([ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md)). De plugin is `@deepseek-ai/dsh-mcp-client`, als `insert` in `cordis.patch.yml`, niet als wijziging van een bestaande rij. Het commando is het absolute pad `~/.local/bin/jarvis-server`. `PATH` zet `~/.jarvis/bin` ervoor, omdat een bureaublad-Zed die map niet heeft.

De model ziet de tools als `mcp__jarvis__searchCode`, `mcp__jarvis__goToDefinition`, `mcp__jarvis__findReferences` en `mcp__jarvis__getIndexStatus`. Een thread die al openstond vóór de insert ziet ze niet. Start een nieuwe thread **DeepSeek Harness**.

## Allowlist en bwrap

Nieuwe threads draaien op `workspace-write` en `approval: ask`. Een pad in de werkmap gaat door. Een pad daarbuiten stopt; verbreden vraagt. Dat staat vast in het profiel, niet in `DSH_PERMISSION_MODE`.

De shell gaat door `packages/lab/cardine-bwrap`. Die mount `/usr` en `/etc` alleen-lezen, en de workspace schrijfbaar. `~/.ssh` is niet zichtbaar. Het DSH-profiel mount `/` alleen-lezen en laat die map wél zien; daarom is die runner niet de kooi ([ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md)).

## make check

`packages/lab/cardine-slice-check` luistert op `agent/turn-stopping`. Een rode `make check` stuurt de agent terug, hoogstens twee keer. De bekende stop "geen app, CHECK leeg" stuurt niet ([ADR 0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md)). Een thread van vóór deze insert ziet de haak niet.

## Controle

`dsh --profile acp` moet afsluiten met code 0 zodra stdin dichtgaat. Een verse start die `initialize` en `session/new` krijgt, laat jarvis `ListToolsRequest` loggen. `searchCode` op `Project-Understanding` raakt deze repo. Een vuile of net geschreven zin zit er niet in tot `jarvis index <pad> --no-semantic` opnieuw draait.

> **Tip:** Gebruik `jarvis index "$(pwd)" --no-semantic` om deze repo te indexeren.
> `--no-semantic` voorkomt dat jarvis een multi-GB semantic-modelgewicht downloadt.
> De lexicale Zoekt-index (searchCode) is daarna beschikbaar voor de agent.