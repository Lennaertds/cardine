# cardine-zed-dsh

> Configuratie om Zed te koppelen aan DeepSeek Harness met een API-key.

Dit is het API-key-pad — alleen de configuratielaag voor wie Zed en DSH al heeft.

## Installatie

```bash
./install.sh
```

## Inhoud

| Bestand | Doel |
|---------|------|
| `install.sh` | Installeert DSH, zet het ACP-profiel, configureert Zed-settings |
| `profile/acp/cordis.patch.yml` | DSH-profiel met DeepInfra-provider (template) |
| `.env.example` | Voorbeeld van `~/.dsh/.env` |

Zie [docs/cardine-zed-dsh.md](docs/cardine-zed-dsh.md) voor volledige documentatie.