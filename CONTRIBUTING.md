# Contributing to AI Commerce Agent Toolkit

Thanks for your interest in improving the toolkit. This guide explains how to propose changes that keep skills reliable across every supported AI host.

## Ways to contribute

- Report bugs or incorrect skill instructions
- Improve documentation and examples
- Add or refine validation coverage
- Fix telemetry path matchers / install scripts for new hosts
- Propose new skills that follow the existing search → generate → validate pattern

## Development setup

1. Fork and clone the repository.
2. Use Node.js 20+ for skill scripts that need local installs.
3. For skills with `package.json` (for example `skills/shopify-liquid`), run `npm install` inside that skill folder.
4. Install the plugin from your local checkout in the host you are testing (Claude Code, Cursor, VS Code, etc.).

## Skill guidelines

- Keep each skill focused on one surface (Admin GraphQL, Liquid, checkout UI, etc.).
- Prefer the established agent loop: search docs → write code → validate → retry.
- Do not break existing skill folder names (`shopify-admin`, `shopify-liquid`, …) without a migration plan — hosts and telemetry matchers depend on them.
- When editing telemetry hooks, update both `hooks/scripts/` and mirrored copies under `skills/*/scripts/`.
- Preserve opt-out behavior via `OPT_OUT_INSTRUMENTATION=true`.

## Pull requests

1. Create a focused branch for one concern.
2. Describe the problem, the change, and how you tested it across at least one AI host.
3. Update `CHANGELOG.md` under an `[Unreleased]` section when the change is user-facing.
4. Keep diffs reviewable — avoid unrelated formatting churn in vendored `assets/types`.

## Code of conduct

Be respectful and constructive. We assume good intent and prioritize clarity for developers shipping commerce software with AI agents.

## Questions

Open an issue in this repository with reproduction steps, host name/version, and the skill involved.
