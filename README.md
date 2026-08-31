# Orshot Skills & Agent Plugin

Agent skills and plugin for [Orshot](https://orshot.com) – the automated visual content generation platform for images, PDFs, and videos.

This repo doubles as the official **Orshot plugin** for agents that support the plugin format (Grok Build, Grok Bot, Claude Code): it bundles the hosted Orshot MCP server (`.mcp.json`) with the skills below.

## Installation

**As skills:**

```bash
npx skills add orshot-hq/orshot-agent-skills
```

**As a plugin (Grok Build):** run `/plugin`, search for **Orshot**, install.

**Grok Bot:** Settings → Plugins → Marketplace → search **Orshot** → install.

On first use the agent prompts you to authorize with your Orshot account over OAuth — no API key to paste.

## Available Skills

### orshot

Comprehensive skill for integrating with the Orshot API. Covers image/PDF/video generation from templates, dynamic parameters, style overrides, AI content generation, SDKs (Node.js, Python, PHP, Ruby), the MCP server, and all integrations.

**Use when:**

- Generating images, PDFs, or videos programmatically from templates
- Building automated marketing visual pipelines
- Creating dynamic social media content (carousels, posts, stories)
- Generating certificates, invoices, tickets, or reports as PDFs
- Automating visual content with Zapier, Make, n8n, or Airtable
- Embedding a design editor into an application
- Working with Orshot API, SDKs, or integrations

### orshot-design

The craft layer for designing Orshot studio templates via the MCP tools: hierarchy, typography and color rules, brand-kit-first workflow, and a render-and-critique loop, so generated templates look professionally designed.

## Network endpoints & credentials

Declared for reviewers and IT admins:

- `https://mcp.orshot.com/mcp` — the hosted Orshot MCP server (streamable HTTP). Auth is OAuth 2.0 (authorization code + PKCE, dynamic client registration) against `https://api.orshot.com`; tokens stay in your MCP client. A workspace API key as a bearer token works for headless use.
- `https://api.orshot.com/v1` — Orshot's public REST API, called only when you follow the skill's API/SDK instructions directly.
- `https://orshot.com/docs/*` — documentation pages the skills may fetch as markdown.

The plugin ships no hooks, no local executables, and no telemetry of its own. The MCP server receives tool calls and their inputs, nothing else. Security details: [orshot.com/agents](https://orshot.com/agents).

## Links

- [Orshot Documentation](https://orshot.com/docs)
- [API Reference](https://orshot.com/docs/api-reference)
- [Orshot for agents](https://orshot.com/agents)
- [Pricing](https://orshot.com/pricing)

## License

[MIT](LICENSE)
