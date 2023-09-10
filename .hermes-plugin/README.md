# AI Commerce Agent Toolkit — Hermes plugin

Hermes client manifest for the AI Commerce Agent Toolkit. For what the toolkit
does, the full skill list, and telemetry details, see the
[parent README](../README.md).

## Install

```
curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit/main/.hermes-plugin/install.sh | bash
```

Re-running the command updates to the latest published version.

Verify:

```
hermes
/plugins
# Expected: ✓ ai-commerce-agent-toolkit v1.6.0 (20 skills, 1 cli command)
```

## Hermes-specific notes

- **Skill loading** — `skill_view("ai-commerce-agent-toolkit:<name>")` (e.g. `ai-commerce-agent-toolkit:shopify-admin`).
- **CLI passthrough** — `hermes shopify <args>` shells out to the Shopify CLI
  on `$PATH`. Override the binary with `HERMES_SHOPIFY_BIN=/abs/path/to/shopify`.
- **Hermes runtime** — `pipx install hermes-agent` (or per
  [upstream docs](https://hermes-agent.nousresearch.com/)).
- **MCP** — the toolkit's `.mcp.json` is empty. If you want MCP access
  from Hermes, add the server to your Hermes MCP config separately.

## Layout

```
.hermes-plugin/
├── plugin.yaml       # Hermes manifest (provides_skills + provides_cli_commands)
├── __init__.py       # register() entry point — auto-discovers ../skills/
├── install.sh        # one-shot install/update script
└── README.md         # this file
```
