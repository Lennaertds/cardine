# Agent-protocollen: MCP, A2A, ACP (+ ANP)

> **Rol:** Standaarden voor tool-koppeling en agent-tot-agent samenwerking.
> **Niet hier:** implementatie van één vendor-SDK als kit-default.

## Oriëntatie (complementair, geen drop-in vervangers)

| Protocol | Richting | Kern |
|----------|----------|------|
| **MCP** (Model Context Protocol) | Verticaal: agent ↔ tools/resources | JSON-RPC; tools, prompts, resources |
| **A2A** (Agent-to-Agent) | Horizontaal: agent ↔ agent | Discovery (Agent Cards), taken delegeren |
| **ACP** (Agent Communication Protocol) | Agent-messaging over HTTP | REST, MIME/multimodal, sessions/routing (o.a. BeeAI/LF-lijn) |
| **ANP** (Agent Network Protocol) | Open netwerk / P2P discovery | DIDs, JSON-LD; bredere “marketplace”-ambitie |

Survey-anker: interoperabiliteitsvergelijkingen MCP/ACP/A2A/ANP (literatuur 2025+). Diepte per protocol hier uitwerken.

## Te schrijven

- Wanneer MCP genoeg is (één agent + tools)
- Wanneer A2A/ACP erbij moet (meerdere organisaties/agents)
- Security: tool poisoning, least privilege (link [skills-veiligheid.md](skills-veiligheid.md))
- Relatie tot Cursor/Claude MCP-gebruik in de praktijk

## Wat kan naar de standaard

Later: korte vermelding “MCP waar de tool het biedt” — **pas** na behoefte in doelprojecten. Nu: geen actie.
