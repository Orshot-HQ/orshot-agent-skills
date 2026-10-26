---
name: orshot-social-media-content
description: "Social media post generator with Orshot: on-brand Instagram, LinkedIn, Facebook, X, Pinterest and TikTok posts and stories (event announcements, quote cards, promos, score updates) from a template you design once, then render with new copy for every post. A Canva alternative an agent can drive by API: brand kit fonts, colors and logo, rotating layouts so posts don't all look the same, real photos over one-off AI images, every platform size from one design. Imports existing Canva designs. Runs over the Orshot MCP server or REST, from a chat or a sheet. Use when: \"make an instagram post for this\", \"social media post generator\", \"turn this sheet into posts\", \"on-brand posts for this week\", \"announcement post\", \"quote post\", \"linkedin post image\". NOT for carousels or TikTok slideshows (use orshot-carousel), ads (use orshot-ad-creative), blog covers (use orshot-blog-images), thumbnails (use orshot-youtube-thumbnail) or posting and scheduling (use orshot-social-media-scheduler)."
homepage: https://orshot.com/agents/skills/social-media-content
license: MIT-0
metadata:
  author: Orshot
  version: "1.3.0"
  mcp-server: orshot
  openclaw:
    emoji: "🎨"
    homepage: https://orshot.com/agents/skills/social-media-content
    primaryEnv: ORSHOT_API_KEY
    requires:
      env: []
      bins: []
    envVars:
      - name: ORSHOT_API_KEY
        required: false
        description: Orshot API key. Only for REST. Template design tools run over the hosted MCP server with OAuth, no key needed.
---

# Orshot Social Media Content: design the template once, post from it forever

A social post from Orshot is a designed template plus fresh copy, not a new AI image every time. This skill is the flow for making one good post template and rendering it for every post after that. Design craft (hierarchy, type, color, anti-patterns) lives in the `orshot-design` skill. Field names and rules live in the docs.

## What people ask for

- "Make an Instagram post for the Fernhill Farm Market on Saturday: date, time, entry price and address, in our brand colors."
- "Here's a post that did well last month. Make five more for next week with the same layout and new copy."
- "Every Monday I'll paste five quotes. Turn them into posts that don't all look the same."
- "Build a score-update story for the Riverside Otters so I can drop in the score after each quarter."
- "Turn each row of this sheet into a LinkedIn image and a story version."
- "Our posts look like generic AI. Redo the template so it looks like us."

## Before you start

- Connect the Orshot MCP server at `https://mcp.orshot.com/mcp` (OAuth, no key). Setup per client: https://orshot.com/docs/integrations/mcp-server.md. The `orshot` skill covers connection and REST.
- Load the `orshot-design` skill. It holds the design rules this flow relies on.
- Template design runs over MCP. The REST create endpoint is Enterprise only: https://orshot.com/docs/api-reference/enterprise-template-create.md.

## Flow

1. **Look for an existing template.** `orshot_list_studio_templates` with a search for the post type. If one fits, skip to step 7.
   **Already designed in Canva?** Do not rebuild it. The user imports it in Orshot Studio from a public share link, so no Canva API access is needed: https://orshot.com/docs/importing-templates/import-from-canva.md. Text and image layers come in as parameters. After the import, go to step 6 and rename the keys that change per post.
2. **Pick the size.** Create takes `canvas_width` and `canvas_height`. Use the pixel size of the platform preset you will render at. Preset names and sizes: https://orshot.com/docs/api-reference/render-from-studio-template.md#smart-resize (or the `orshot://formats` MCP resource). There is no carousel preset; carousels are in `orshot-carousel`.
3. **Read the spec, the pack and the brand.**
   - `orshot://template-design-spec` for the template JSON. Same content as https://orshot.com/docs/definitions/template-json.md.
   - `orshot://design-pack/social-media` for archetypes and a recipe. Pick an archetype different from the last template of this type.
   - `orshot_get_brand_kit` when the post should be on brand.
   - A post that worked, if the user shares one. Copy its structure and hierarchy, not its words.
4. **Create** with `orshot_create_template_design`: the complete `pages_data` in one call, real copy, and `includeThumbnails: true`. Mark every field that changes per post as a dynamic parameter with a snake_case `parameterId` (`headline`, `subtitle`, `product_image`). Text fitting is set inside each text layer's `style`: https://orshot.com/docs/orshot-studio/text-modes.md.
5. **Critique.** Read the thumbnail and the design check in the result. Fix real problems with one `orshot_update_template_design` call, or `orshot_patch_template_elements` for single layers. Never ship the first pass unseen.
6. **Check the keys.** `orshot_get_studio_template_modifications` lists the exact keys a render accepts.
7. **Render** with real copy (`orshot_render_template`) and show the user the output.
8. **Hand off.** Posting, scheduling and analytics are in `orshot-social-media-scheduler`. Keep the template: every future post is a render, not a redesign. For posts that should be made with no one in the chat (a new sheet row, every Monday), see the `orshot` skill's [`references/recurring-automation.md`](https://github.com/Orshot-HQ/orshot-agent-skills/blob/main/skills/orshot/references/recurring-automation.md) and https://orshot.com/workflows/images-from-sheet-to-social.

## Example: a weekly quote post

1. `orshot_get_brand_kit` returns the brand's colors, fonts and logo.
2. Read `orshot://design-pack/social-media` and pick a type-led archetype.
3. `orshot_create_template_design` with name "Quote post (portrait)", `canvas_width: 1080`, `canvas_height: 1350`, one page with a quote text layer (`parameterId: "quote"`), an author line (`author`), the logo, and `includeThumbnails: true`.
4. Fix what the thumbnail shows, then render each week:

```json
{
  "templateId": 123,
  "modifications": {
    "quote": "Ship the boring version first.",
    "author": "Ana Ruiz, CTO"
  },
  "format": "png",
  "extraSizes": ["instagram-story", "linkedin-post"]
}
```

These are `orshot_render_template` arguments. Over MCP, `format`, `scale`, `includePages`, `size` and `extraSizes` are flat arguments. Over REST they go inside `response`: https://orshot.com/docs/api-reference/render-from-studio-template.md. `extraSizes` re-lays the same design for each extra size in the same call.

## Example: an event announcement

The user: "Make an Instagram post for the Fernhill Farm Market on Saturday: date, time, entry price and address, in our brand colors."

Every fact that changes is its own parameter, so the next market is a render with new values and no design work:

```json
{
  "templateId": 124,
  "modifications": {
    "event_name": "Fernhill Farm Market",
    "event_date": "Sat 14 Nov",
    "event_time": "8am to 1pm",
    "price": "Entry $3, kids free",
    "address": "12 Mill Lane, Fernhill",
    "photo": "https://.../stall.jpg"
  },
  "format": "png",
  "extraSizes": ["instagram-story"]
}
```

The same template covers score updates and price changes: `score_home`, `score_away` and `quarter` as fields, and the user sends only the new values.

## Example: a week of posts that don't all look the same

1. Build two or three templates for the same post type, each from a different archetype in `orshot://design-pack/social-media`, with the same parameter ids (`quote`, `author`).
2. Split the copy into fields (`hook`, `point`, `sign_off`) rather than one long text field, so each part changes per post.
3. Render in turn: Monday template A, Tuesday B, Wednesday C, Thursday A. The user's input stays the same; only the layout rotates.

## Example: make an existing template less generic

1. `orshot_get_studio_template` to read the current design.
2. Check it against the anti-patterns in `orshot-design`.
3. `orshot_patch_template_elements` with `layer_operations` for the layers that change, `includeThumbnails: true`, then look at the result.

## Rules

- One template per post type, reused. Do not redesign per post.
- Vary the archetype between templates of the same type.
- Render before you call it done. A thumbnail is a preview; the render is what ships.
- Images, in this order: brand kit images, the user's own photos, then stock (`orshot_search_stock_media`). Use AI images only when the user asks for them.
- For a batch the user files by hand, save renders to their Google Drive folder with a file name per render: https://orshot.com/docs/integrations/google-drive.md.
- A render costs credits: https://orshot.com/docs/definitions/credits-usage.md. Say the cost before a large batch.

Related skills: `orshot` (connection, REST, render options), `orshot-design` (design craft), `orshot-carousel` (multi-slide posts), `orshot-social-media-scheduler` (posting and analytics).
