# How-to — Zed + DeepSeek Harness

> **Rol:** Het lab-pad aanzetten: upstream Zed, gepinde `dsh --profile acp`, API-key lokaal.
> **Niet hier:** het besluit ([ADR 0003](../decisions/0003-de-agent-loop-is-upstream-deepseek-harness-gepind-als-dsh-profile-acp-zonder-fork.md), [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md)); de andere agent-paden ([PRODUCT.md](../product/PRODUCT.md)).

## Snelle weg (nieuwe machine)

Op een verse Arch Linux / Hyprland-machine volstaat één commando in deze repo:

```bash
make install-lab
```

Het script in `scripts/install-lab.sh`:

1. Checkt of `zeditor`, `bwrap`, `node` (≥ 24.9) en `jarvis-server` aanwezig zijn.
2. Installeert `@deepseek-ai/dsh@0.2.2-rc.1` via npm als die versie nog niet staat.
3. Genereert `~/.dsh/profiles/acp/cordis.patch.yml` met DeepInfra-provider, jarvis MCP, sandbox-beleid en slice-check.
4. Voegt het agent-server-profiel "DeepSeek Harness" toe aan `~/.config/zed/settings.json`.
5. Maakt `~/.dsh/.env` aan met `DEEPSEEK_API_KEY=` (chmod 600) — overschrijft nooit een bestaande key.
6. Eindigt met een duidelijke melding dat je alleen nog je DeepInfra API-key hoeft in te vullen.

**Let op:** `make install-lab` installeert geen systeempakketten (pacman/flatpak) voor ontbrekende tools. Het checkt alleen of ze op PATH staan. Installeer ontbrekende tools eerst handmatig en draai het script opnieuw.

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

### Zed

In `~/.config/zed/settings.json`, onder `agent_servers`:

```json
"DeepSeek Harness": {
  "type": "custom",
  "command": "/home/ventje/.local/bin/dsh",
  "args": ["--profile", "acp"]
}
```

Zed leest die wijziging zelf. In het Agent-paneel start je een thread **DeepSeek Harness**.

Het meegeleverde ACP-profiel opent een sessie op `deepseek-ai/DeepSeek-V4-Flash` via DeepInfra. [ADR 0008](../decisions/0008-het-coding-model-is-deepseek-flash-en-claude-is-de-tweede-provider.md) noemt `deepseek-flash`; het exacte model-id op DeepInfra is `deepseek-ai/DeepSeek-V4-Flash`.

## jarvis

Het ACP-profiel mount jarvis als MCP ([ADR 0006](../decisions/0006-de-agent-zoekt-via-jarvis-als-mcp-zed-zoeken-en-lsp-blijven-van-de-editor.md)). De plugin is `@deepseek-ai/dsh-mcp-client`, als `insert` in `cordis.patch.yml`, niet als wijziging van een bestaande rij. Het commando is het absolute pad `~/.local/bin/jarvis-server`. `PATH` zet `~/.jarvis/bin` ervoor, omdat een bureaublad-Zed die map niet heeft.

De model ziet de tools als `mcp__jarvis__searchCode`, `mcp__jarvis__goToDefinition`, `mcp__jarvis__findReferences` en `mcp__jarvis__getIndexStatus`. Een thread die al openstond vóór de insert ziet ze niet. Start een nieuwe thread **DeepSeek Harness**.

## Allowlist en bwrap

Nieuwe threads draaien op `workspace-write` en `approval: ask`. Een pad in de werkmap gaat door. Een pad daarbuiten stopt; verbreden vraagt. Dat staat vast in het profiel, niet in `DSH_PERMISSION_MODE`.

De shell gaat door `scripts/cardine-bwrap`. Die mount `/usr` en `/etc` alleen-lezen, en de workspace schrijfbaar. `~/.ssh` is niet zichtbaar. Het DSH-profiel mount `/` alleen-lezen en laat die map wél zien; daarom is die runner niet de kooi ([ADR 0007](../decisions/0007-tool-goedkeuring-is-een-workspace-allowlist-en-de-shell-draait-onder-bwrap.md)).

## make check

`scripts/cardine-slice-check` luistert op `agent/turn-stopping`. Een rode `make check` stuurt de agent terug, hoogstens twee keer. De bekende stop "geen app, CHECK leeg" stuurt niet ([ADR 0001](../decisions/0001-runtime-stack-bewust-uitgesteld-tot-expliciete-pi-of-ts-keuze.md)). Een thread van vóór deze insert ziet de haak niet.

## Controle

`dsh --profile acp` moet afsluiten met code 0 zodra stdin dichtgaat. Een verse start die `initialize` en `session/new` krijgt, laat jarvis `ListToolsRequest` loggen. `searchCode` op `Project-Understanding` raakt deze repo. Een vuile of net geschreven zin zit er niet in tot `jarvis index` opnieuw draait.