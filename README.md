# AI Commerce Agent Toolkit

**Production-ready agent skills for building, validating, and operating commerce applications — directly inside your AI coding environment.**

AI Commerce Agent Toolkit connects Claude Code, Cursor, Codex, VS Code, Hermes, Gemini, and Pi to commerce documentation, API schemas, validation pipelines, and store workflow tooling. Your agent can search official docs, generate GraphQL and Liquid, validate against live schemas, and drive store operations without leaving the editor.

---

## The Problem

Commerce development spans Admin APIs, Storefront GraphQL, Liquid themes, UI extensions, Functions, and CLI workflows. AI assistants often produce plausible but invalid code — wrong API versions, outdated fields, or theme patterns that fail theme-check.

Teams need agents that can:

- Retrieve authoritative documentation at generation time
- Validate output against real schemas before you paste it into production
- Operate consistently across multiple AI hosts

## Key Features

- **Docs-aware generation** — Search platform documentation and API schemas from inside the agent loop
- **Schema validation** — Validate GraphQL, Liquid, UI extensions, and Functions before merge
- **21 specialized skills** — Admin, Storefront, Liquid, Polaris surfaces, POS, Hydrogen, Partner, Payments, ShopifyQL, UCP, and more
- **Multi-harness plugins** — One toolkit installs across Claude Code, Cursor, Codex, VS Code/Copilot, Hermes, Gemini CLI, Antigravity, and Pi
- **Store workflow hooks** — CLI passthrough for auth, store execute, and app/extension operations
- **Telemetry opt-out** — Usage instrumentation is on by default; disable with `OPT_OUT_INSTRUMENTATION=true`

## Architecture Overview

```
AI Host (Claude / Cursor / Codex / VS Code / Hermes / ...)
        |
        v
Plugin manifests (.claude-plugin, .cursor-plugin, ...)
        |
        v
skills/*/SKILL.md  (agent instructions)
        |
        +--> search_docs.mjs   (docs search)
        +--> validate.mjs      (schema checks)
        +--> track-telemetry   (optional analytics)
```

Each skill is a self-contained folder under `skills/` with instructions, optional local dependencies, and scripts the agent invokes during the search → generate → validate loop.

## Installation

Replace `YOUR_GITHUB_USERNAME` with your GitHub account or organization.

### Claude Code

```bash
claude plugin install ai-commerce-agent-toolkit
```

Or add from source:

```text
/plugin marketplace add YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit
/plugin install ai-commerce-agent-toolkit@ai-commerce-agent-toolkit
```

### Cursor

In Cursor Chat:

```text
/add-plugin ai-commerce-agent-toolkit
```

### OpenAI Codex

```bash
codex plugin add ai-commerce-agent-toolkit
```

### VS Code / GitHub Copilot

1. Enable Agent plugins preview in VS Code settings.
2. Command Palette → **Chat: Install Plugin From Source**
3. Paste:

```text
https://github.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit
```

### Hermes

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit/main/.hermes-plugin/install.sh -o /tmp/acat-hermes-install.sh
bash /tmp/acat-hermes-install.sh
```

### Gemini CLI

```bash
gemini extensions install https://github.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit
```

### Pi

```bash
pi install git:github.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit
```

### Antigravity

```bash
agy plugin install https://github.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit
```

## Usage Examples

**Admin GraphQL**

```text
Create a product with variants using the Admin API, then validate the mutation.
```

**Liquid themes**

```text
Generate a product media gallery section and run theme-check validation.
```

**UI extensions**

```text
Build a checkout UI extension that shows free shipping progress and validate the target types.
```

**Store CLI**

```text
Authenticate against my store and list recent orders via store execute.
```

## Technology Stack

| Layer | Technology |
|-------|------------|
| Skill format | `SKILL.md` (YAML frontmatter + instructions) |
| Scripts | Node.js ESM (`.mjs`) |
| Validation | GraphQL schemas, theme-check, TypeScript + vendored UI types |
| Docs search | Platform assistant search API |
| Hosts | Claude Code, Cursor, Codex, VS Code, Hermes, Gemini, Pi, Antigravity |
| License | MIT |

## Developer Workflow

1. **Install** the plugin for your AI host.
2. **Ask** the agent to perform a commerce task (query, theme, extension, Function).
3. The agent **searches docs**, drafts code, then **validates** via skill scripts.
4. Iterate until validation passes (typically within a short retry loop).
5. Opt out of telemetry when needed:

```bash
export OPT_OUT_INSTRUMENTATION=true
```

### Local development

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/ai-commerce-agent-toolkit.git
cd ai-commerce-agent-toolkit

# Skills with local deps (e.g. Liquid / UI validation)
cd skills/shopify-liquid && npm install
```

Point your host at this checkout using its “install from source” / marketplace path.

## Repository Layout

```text
.
├── skills/                 # Agent skills (SKILL.md + scripts + assets)
├── hooks/                  # PostToolUse / prompt telemetry hooks
├── .claude-plugin/         # Claude Code marketplace + plugin
├── .cursor-plugin/         # Cursor marketplace + plugin
├── .codex-plugin/          # OpenAI Codex plugin
├── .hermes-plugin/         # Hermes manifest + installer
├── .agents/                # Antigravity marketplace
├── plugin.json             # VS Code / Copilot plugin
├── gemini-extension.json   # Gemini CLI extension
├── package.json            # Pi skills pointer + package metadata
└── README.md
```

## Roadmap

- [ ] Broader commerce protocol coverage beyond current UCP skill
- [ ] Richer offline schema caches for air-gapped validation
- [ ] First-class skill templates for custom internal APIs
- [ ] Improved multi-skill orchestration for end-to-end app scaffolds
- [ ] Hardened CI fixtures for validate/search script regressions

## Telemetry

Skill scripts and host hooks may send usage events (tool name, skill version, client metadata, and optionally truncated prompts/validation context) to the platform usage endpoint. This is **on by default**.

Disable for scripts, MCP-related surfaces, and hooks:

```bash
OPT_OUT_INSTRUMENTATION=true
```

See [`hooks/README.md`](./hooks/README.md) for coverage details.

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## License

MIT — see [LICENSE](./LICENSE).

This project includes software originally published by Shopify Inc. under the MIT License. Platform API names, CLI commands, and `shopify-*` skill identifiers refer to the commerce platform domain and are retained for compatibility.
