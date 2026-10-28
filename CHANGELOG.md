# Changelog

One entry per published ClawHub version. Skill versions live in each `SKILL.md` frontmatter (`metadata.version`).

## Unreleased

Posting over MCP is two calls: `orshot_render_template` only renders, and `orshot_publish_social_post` posts the render's URL (MCP server #63). Skills that used `publish` on the MCP render now render, then post. REST examples keep `publish` on the render body, which the API still takes. A post saved without an account is sent after the user connects one and the agent adds it with `orshot_update_social_post`; nothing sends it on its own.

Moved the OpenClaw skills and publish setup here from Orshot-HQ/orshot-openclaw; this repo is now the one home for every Orshot skill and plugin manifest.

Docs-first rewrite of every skill: skills now hold the flow and worked examples, and link the Orshot docs (`https://orshot.com/docs/<page>.md`) and the MCP resources for parameters, values, limits and schemas. Removed `orshot/references/` api-reference, render-configuration, integrations-and-errors, embed, oauth-developer-apps and template-design-spec; `orshot-design/references/social-media.md`; `orshot-social-media-content/references/social-media.md`; `orshot-pdf-generator/references/pdf-options.md`; `orshot-video-generator/references/video-template-spec.md`. Every remaining claim was checked against the API, renderer and shipped MCP code; features that exist only on unmerged MCP branches were taken out.

Reddit research pass (Oct 26 2026, about 2,300 posts from the last year): descriptions lead with the words people use for each job, every skill has example prompts in users' words, and flows gained the steps those threads asked for. Every capability was checked against the docs and the MCP server first.

Blind-test pass (Oct 27 2026, 8 agents, 25 deliverables through the MCP server): blog images, carousel, YouTube thumbnail and PDF generator fixed where the agents got stuck. Shorts covers, Pinterest pins and square cover copies are their own pages instead of `extraSizes`; A4 and Letter canvas sizes and no `pdfDpi` for paper; Smart Stacking JSON; chart and QR image fields; trimmed cutouts; TikTok safe areas; fixed wording marked `parameterizable: false`; the full blueprint color swap list and a darker muted ink (`#6B6A66`) that passes the contrast check; which design warnings can stay.

### orshot-blog-images 1.0.0

- First release. Cover from a reusable 6-style cover template, 3 to 6 in-article images from 7 tested layouts (13 blueprint pages in `references/blueprints/`), brand swap table, style guide, automation for a cover on every new post.
- Description leads with "featured image" and "OG image"; example prompts.
- Per-platform roads: WordPress plugin, Webflow preset, REST with a Media Library upload first, dynamic `og:image` URL.
- One render per post, a review step while the post is a draft, and a Backfill section for old posts.

### orshot-video-generator 1.0.0

- First release. Films are the default video: one template whose pages are scenes joined by transitions and rendered as one MP4 (Film mode, Motion v2 and SVG part animation from MCP v1.28.0).
- Flow: beat sheet, `orshot_plan_design` with `duration_seconds`, drawn SVG previewed with `orshot_preview_element`, one create with `film` and `includeThumbnails`, film and pacing checks, `orshot_verify_design`, one async MP4 render.
- Pacing rule in the skill, matching the MCP reading check: 0.4 s per word read along as a block enters, blocks in entrance order, 1 s hold before the cut, last arrival holds 2 s, draws 2 to 3 s, cuts 0.9 to 1.2 s, never speed the motion up.
- `references/film-recipes.md`: chart or stat explainer, tips reel, listing reel, launch teaser, product promo, brand line-art film, occasion reel, testimonial and character dialogue, timed from the reference films that passed review.
- `references/narrated-shorts.md`: voiceover shorts, podcast clips, captions on an existing clip and the faceless Shorts pipeline in n8n. These stay on `combinePages` because films do not burn captions or take a per-render `audioSource` yet.
- Description leads with faceless video and Shorts and adds product, listing, chart and brand films; example prompts in users' words, including non-English reels.

### orshot-ad-creative 1.0.0

- First release. One ad template rendered in every placement size with Smart Resize, A/B variants in one batch, catalog ads from a feed, animated banners.
- Description leads with static Meta ad creatives, variations and creative fatigue; example prompts.
- Refresh-before-fatigue weekly job, top-third hook rule, product background removal, AI images kept with real text on top.
- Rebuild a winning layout from the user's own assets only; one template per client for agencies.

### orshot-youtube-thumbnail 1.0.0

- First release. Click rules, five layouts (`references/layouts.md`), one template per channel style, A/B variants, a 9:16 Shorts copy, automation per upload.
- Description and rules put real frames and faces over generated ones, with no CTR promise; example prompts.
- Match the channel's current style first; new Screenshot + name layout.
- Redo thumbnails on old videos; per-upload n8n flow (RSS, render, `thumbnails.set` with the user's own OAuth).

### orshot-pdf-generator 1.0.0

- First release. Invoices, certificates, reports and proposals from a template plus data, PDF options linked from the docs, batches from sheets, CRMs and webhooks.
- Description leads with invoices and bulk certificates, with a NOT-for line for extracting data from PDFs; example prompts.
- Run once per row (status column, dedupe key, URL written back, stop on failure); longest-row test before a batch; line items flattened first.
- Async plus webhook when Zapier or Make times out; import an existing Canva or Figma design first; Notion source and the Spreadsheets tool.

### orshot 1.5.0

- Homepage moved to orshot.com/agents/skills.
- Description is about Orshot itself and routes each job to its use-case skill by name; job phrases that competed with those skills are gone.
- Routing table and trust lines at the top; a "Run once per item" pattern in `references/recurring-automation.md`.
- Render `publish` example fixed: over REST the render reads `isDraft` and `schedule.scheduledFor`, not `status`, so the old example could post immediately.

### orshot-carousel 1.1.0

- Homepage moved to orshot.com/agents/skills/carousel; render `publish` example fixed (REST reads `isDraft` and `schedule`).
- Description leads with "TikTok slideshow" and faceless slideshows; example prompts.
- Music section: TikTok `autoAddMusic`, and Orshot has no music option for Instagram.
- Two more slide formulas, an image rights line, a used-image log, a month of slideshows with one approval for the batch; MP4 slideshows with a song are films and go to orshot-video-generator; Workflows for daily runs; Canva import.

### orshot-social-media-scheduler 1.1.0

- Homepage moved to orshot.com/agents/skills/social-media-scheduler; render `publish` example fixed (REST reads `isDraft` and `schedule`).
- Description leads with "social media scheduler and auto-poster" and the render-and-schedule-in-one-call pitch.
- Approve a batch of drafts once; worked example for a week of posts in one conversation.
- Account checks (two accounts on one platform, one workspace per client), a check before retrying a timed-out publish, and Orshot Workflows for posting that runs without the agent.

### orshot-social-media-content 1.3.0

- Homepage moved to orshot.com/agents/skills/social-media-content.
- Description leads with "social media post generator" and names the Canva alternative and Canva import.
- Worked examples: an event announcement with one parameter per fact, and rotating layouts across a week.
- Image source order, Google Drive file names for batches, and Workflows for unattended runs.

### orshot-design 1.2.0

- Full frontmatter (homepage, license, OpenClaw metadata) and a description that names it the shared craft base.
- Video motion rules follow the film pacing rule (every word gets read, cuts 0.9 to 1.2 s, one cut family per video) and link the film spec and film pack.

## 2026-10-22

### orshot 1.4.0

- Description and body rewritten around the jobs people search for: image generation, PDF generation, video generation from templates, OG images, social media posts, carousels, thumbnails, invoices, certificates, and the 13 social platforms.
- MCP connection first (`openclaw mcp add` + `openclaw mcp login`), REST with an API key as the headless fallback. Every capability names the MCP tool before the REST route.
- Capability list and example prompts mirror the Orshot connector listing in the Claude directory.
- Social posting section: accounts, render and post in one call, post existing media, held posts, analytics and best time. 1.3.0 covered render plus publish and account listing only.
- Safety rules for agents and confirmation notes next to delete routes and workflow runs.
- `metadata.openclaw` block (emoji, homepage, `primaryEnv`, `envVars` with `required: false` because OAuth over MCP needs no key).
- `Bearer <ORSHOT_API_KEY>` placeholders replaced with `$ORSHOT_API_KEY`, which the ClawHub scanner no longer reads as a hardcoded secret.
- SDK installs pinned (`orshot@0.3.1`, `orshot==0.2.0`, `rishimohan/orshot:0.2.0`, `gem orshot -v 0.2.0`).
- SKILL.md shrunk from 57 KB to about 16 KB; long material moved to `references/`, loaded on demand.

### orshot-social-media-scheduler 1.0.0

- First release. Connect over MCP, list accounts, send the user to the dashboard to connect accounts when the list is empty, draft, schedule and publish to 13 platforms, manage held posts, analytics and best time to post, six common patterns, safety rules, gotchas.

### orshot-carousel 1.0.0

- First release. Six-slide formula, template rules with TikTok safe zones, create the template if none exists, render in one call, post as a draft through Orshot or hand to Postiz, learning loop.

### orshot-social-media-content 1.2.0

- Renamed from `orshot-design` for ClawHub (the agent-skills plugin keeps the old name). Description rewritten around social media content, Instagram post, LinkedIn post, TikTok and social media design.
- New opening section: connect over MCP, then generate a template for a platform (preset table, spec, brand kit, create with thumbnails, critique, render, hand off to the scheduler and carousel skills).
- Craft rules, systems, compatibility, motion and anti-patterns unchanged. Em dashes replaced.
- `metadata.openclaw` block, homepage and license added.
