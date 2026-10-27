# Orshot Agent Skills

Skills that let Claude Code, Codex, Cursor, OpenClaw and other agents generate images, PDFs and videos from templates with the [Orshot](https://orshot.com) API. One skill per job: blog featured images and OG images, invoice and certificate PDFs, faceless shorts and reels, static ads in every size, TikTok slideshows and carousels, YouTube thumbnails, social posts and scheduling.

```bash
npx skills add orshot-hq/orshot-agent-skills
claude mcp add --transport http orshot https://mcp.orshot.com/mcp
```

- Plain Markdown: SKILL.md files and JSON layouts. No hooks, no local executables, no telemetry.
- No API key to paste. The hosted MCP server (Claude calls it a connector) signs in with OAuth. A key is only needed for cron jobs and n8n.
- Nothing is posted, emailed or deleted without your yes. Bulk renders state the credit cost first.
- Needs an Orshot account; renders run on Orshot's servers. 100 free credits every month, [pricing](https://orshot.com/pricing).
- Real outputs for every skill: **[orshot.com/agents/skills](https://orshot.com/agents/skills)**. Each skill page is also readable by agents: paste its link into the chat and ask for the job.

## Skills

| Skill | What it makes | Page |
| --- | --- | --- |
| [`orshot-blog-images`](skills/orshot-blog-images/SKILL.md) | Featured images and OG images for every blog post, plus in-article images | [orshot.com/agents/skills/blog-images](https://orshot.com/agents/skills/blog-images) |
| [`orshot-video-generator`](skills/orshot-video-generator/SKILL.md) | Faceless Shorts, Reels, launch videos and short video ads with captions, rendered to MP4 | [orshot.com/agents/skills/video-generator](https://orshot.com/agents/skills/video-generator) |
| [`orshot-ad-creative`](skills/orshot-ad-creative/SKILL.md) | Static Meta ad creatives, test variations and catalog ads in every placement size | [orshot.com/agents/skills/ad-creative](https://orshot.com/agents/skills/ad-creative) |
| [`orshot-youtube-thumbnail`](skills/orshot-youtube-thumbnail/SKILL.md) | Thumbnails in your channel's style from your own frames and face, with A/B variants | [orshot.com/agents/skills/youtube-thumbnail](https://orshot.com/agents/skills/youtube-thumbnail) |
| [`orshot-pdf-generator`](skills/orshot-pdf-generator/SKILL.md) | Invoice, certificate and report PDFs from a template plus sheet, CRM or webhook data | [orshot.com/agents/skills/pdf-generator](https://orshot.com/agents/skills/pdf-generator) |
| [`orshot-carousel`](skills/orshot-carousel/SKILL.md) | TikTok slideshows plus Instagram and LinkedIn carousels, posted as a draft | [orshot.com/agents/skills/carousel](https://orshot.com/agents/skills/carousel) |
| [`orshot-social-media-content`](skills/orshot-social-media-content/SKILL.md) | On-brand posts and stories for every platform | [orshot.com/agents/skills/social-media-content](https://orshot.com/agents/skills/social-media-content) |
| [`orshot-social-media-scheduler`](skills/orshot-social-media-scheduler/SKILL.md) | Schedule and auto-post to 13 platforms, then read analytics | [orshot.com/agents/skills/social-media-scheduler](https://orshot.com/agents/skills/social-media-scheduler) |

Base skills, loaded by the ones above:

| Skill | What it covers |
| --- | --- |
| [`orshot`](skills/orshot/SKILL.md) | The API, render options, integrations and gotchas. Load it for any Orshot task. |
| [`orshot-design`](skills/orshot-design/SKILL.md) | Design rules every template follows: hierarchy, two fonts, one accent, a critique pass. |

## Install

Every option below gives your agent the same two things: the skills in `skills/` and the hosted Orshot MCP server at `https://mcp.orshot.com/mcp`. The server signs in with OAuth in the browser, so there is no API key to paste. A workspace API key sent as a bearer token also works for headless jobs.

### Any agent with Agent Skills (skills.sh)

Claude Code, Codex, Cursor, GitHub Copilot, Gemini CLI, OpenCode, Windsurf, Kiro, Qwen Code, Amp, Factory Droid, Hermes and more:

```bash
npx skills add orshot-hq/orshot-agent-skills
npx skills add orshot-hq/orshot-agent-skills --skill orshot-blog-images   # one skill
```

Then add the MCP server in your agent's MCP settings, for example `claude mcp add --transport http orshot https://mcp.orshot.com/mcp`.

### Claude Code

```bash
claude plugin marketplace add Orshot-HQ/orshot-agent-skills
claude plugin install orshot@orshot
```

Or inside a session: `/plugin install orshot --marketplace Orshot-HQ/orshot-agent-skills`.

### Claude.ai and Claude Desktop

Add the Orshot connector from the Connectors directory, or add `https://mcp.orshot.com/mcp` as a custom connector. To add a skill, run `./scripts/build-dist.sh` in a clone of this repo and upload a zip from `dist/claude-skills/` in **Customize > Skills**.

### Codex and ChatGPT

```bash
codex plugin marketplace add Orshot-HQ/orshot-agent-skills
```

Then open the Plugins directory, pick the **Orshot** marketplace and install **Orshot**. The repo carries an Agent Plugins `plugin.json` with a `.codex-plugin/plugin.json` fallback.

### Cursor

Install **Orshot** from the [Cursor Marketplace](https://cursor.com/marketplace). Teams can also import this repo under Dashboard > Plugins & MCPs > Add Marketplace > Import from Repo.

### GitHub Copilot CLI and VS Code

```bash
copilot plugin install Orshot-HQ/orshot-agent-skills
```

In VS Code, run **Chat: Install Plugin From Source** with `https://github.com/Orshot-HQ/orshot-agent-skills`.

### Gemini CLI

```bash
gemini extensions install https://github.com/Orshot-HQ/orshot-agent-skills
```

### Grok Build

Run `/plugin`, search **Orshot** and install it.

### OpenClaw

```bash
openclaw plugins install clawhub:orshot
openclaw mcp login orshot
```

Each skill is also listed on its own on [ClawHub](https://clawhub.ai) under the `orshot` publisher.

### Qwen Code

```bash
qwen extensions install Orshot-HQ/orshot-agent-skills
```

### Factory Droid

```bash
droid plugin marketplace add https://github.com/Orshot-HQ/orshot-agent-skills
droid plugin install orshot@orshot
```

### Kiro

Powers panel > Add Custom Power > Import power from GitHub, then paste `https://github.com/Orshot-HQ/orshot-agent-skills`.

### Hermes Agent

```bash
hermes skills tap add Orshot-HQ/orshot-agent-skills
```

Then add the MCP server under `mcp_servers` with `auth: oauth` and run `hermes mcp login orshot`.

Setup guides for every agent: [orshot.com/agents](https://orshot.com/agents). Privacy policy: [orshot.com/privacy](https://orshot.com/privacy). Terms: [orshot.com/terms](https://orshot.com/terms). Support: [orshot.com/contact](https://orshot.com/contact) or hi@orshot.com.

## Network endpoints and credentials

Declared for reviewers and IT admins:

- `https://mcp.orshot.com/mcp`: the hosted Orshot MCP server (streamable HTTP). Auth is OAuth 2.0 (authorization code with PKCE, dynamic client registration) against `https://api.orshot.com`; tokens stay in your MCP client. A workspace API key as a bearer token works for headless use.
- `https://api.orshot.com/v1`: Orshot's REST API, called only when you follow a skill's REST instructions.
- `https://orshot.com/docs/*`: documentation pages the skills may fetch as markdown.

The skills and plugin ship no hooks, no local executables and no telemetry. The MCP server receives tool calls and their inputs, nothing else.

## Publishing (maintainers)

- ClawHub skills: `./scripts/publish.sh --dry-run`, then a `v*` tag runs `.github/workflows/publish.yml`. Bump `metadata.version` in a skill's frontmatter and add a CHANGELOG entry first.
- ClawHub bundle plugin: bump `version` in every manifest, run `./scripts/check.sh` (it fails when versions differ), then `./scripts/publish-plugin.sh`.
- Claude.ai skill zips and the OpenAI plugin portal zip: `./scripts/build-dist.sh` writes them to `dist/` (gitignored).

## Links

- [Orshot docs](https://orshot.com/docs) · [API reference](https://orshot.com/docs/api-reference) · [Pricing](https://orshot.com/pricing)

## License

MIT for the plugin and every skill.

The format research the skills design from (post, ad and video post formats, thumbnail layouts) is served by the Orshot MCP server: `orshot_plan_design` returns the formats that fit a job, `orshot_get_design_spec` reads a whole reference. Both need an Orshot login. It is not part of this repo.
