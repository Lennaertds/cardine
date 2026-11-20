# Package: `cardine-zed-dsh`

> **Configuratie om Zed te koppelen aan DeepSeek Harness met een API-key.**
> Dit is het API-key-pad uit ADR 0010 — alleen de configuratielaag voor wie Zed en DSH al heeft.

| Veld | Waarde |
|------|--------|
| **Package** | `cardine-zed-dsh` |
| **Doelgroep** | Wie Zed + DeepSeek Harness met API-key wil |
| **Bron** | `cardine/packages/zed-dsh/` |
| **Installatie** | `install.sh`, npm |
| **Afhankelijk van** | DSH (moet al geïnstalleerd zijn) |

---

## Inhoud

| Bestand | Doel |
|---------|------|
| `install.sh` | Installeert DSH, zet het ACP-profiel, configureert Zed-settings |
| `profile/acp/cordis.patch.yml` | DSH-profiel met DeepInfra-provider (template) |
| `.env.example` | Voorbeeld van `~/.dsh/.env` |
| `CHANGELOG.md` | Versiehistorie |
| `README.md` | Uitleg: API-key aanvragen, profiel activeren, testen |

### Mapstructuur

```
packages/zed-dsh/
├── CHANGELOG.md
├── README.md
├── install.sh
├── .env.example
└── profile/
    └── acp/
        └── cordis.patch.yml
```

## Relatie tot cardine-lab

| Package | Bereik |
|---------|--------|
| **`cardine-lab`** | Volledige installatie: Zed + DSH + Jarvis + indexering + bwrap + structure |
| **`cardine-zed-dsh`** | Alleen de configuratielaag voor wie Zed en DSH al heeft |

`cardine-lab` installeert alles-in-één; `cardine-zed-dsh` is voor wie al een werkstation heeft en alleen de DSH-Zed-koppeling nodig heeft.

## Installatie

```bash
# Via het installatiescript
./packages/zed-dsh/install.sh

# Of via npm (indien gepubliceerd)
# npm install -g cardine-zed-dsh
```

## Versiebeheer

Zie [VERSIONING.md](VERSIONING.md) voor het algemene schema.
CHANGELOG: `packages/zed-dsh/CHANGELOG.md` (eigen versie, SemVer).
Git-tag: `zed-dsh-v<semver>`.