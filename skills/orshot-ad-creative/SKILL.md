---
name: orshot-ad-creative
description: "Static ad creative generator with Orshot: Facebook and Instagram ad creatives, Meta story ads, catalog ads and display banners rendered from one template with real headlines, offers, prices, logos and product photos, so every test variation is on brand and spelled right. Smart Resize makes every placement size in one call, a batch render makes hook and angle variants, catalog ads render one image per product from a sheet, a CSV or the Orshot Shopify app, plus short GIF or MP4 banners. Use when: \"static ad creatives for Meta\", \"ad variations to test\", \"our ads have creative fatigue\", \"15 ad variants from this product photo\", \"facebook ad maker\", \"catalog ads for my store\", \"banner ads in every size\", \"AI ad generator\". NOT for organic social posts (use orshot-social-media-content), carousels (use orshot-carousel), video ads with footage or voiceover (use orshot-video-generator), YouTube thumbnails (use orshot-youtube-thumbnail) or posting and scheduling (use orshot-social-media-scheduler)."
homepage: https://orshot.com/agents/skills/ad-creative
license: MIT-0
metadata:
  author: Orshot
  version: "1.0.0"
  openclaw:
    emoji: "📣"
    homepage: https://orshot.com/agents/skills/ad-creative
    primaryEnv: ORSHOT_API_KEY
    requires:
      env: []
      bins: []
    envVars:
      - name: ORSHOT_API_KEY
        required: false
        description: Orshot API key. Only for REST and scheduled jobs. Not needed over the hosted MCP server with OAuth.
---

# Orshot Ad Creative: one template, every ad size, every variant

An ad campaign is one design repeated many times: three Meta sizes, five display sizes, four headline tests, a new price every week. Drawing each one is slow, and image models cannot be trusted with prices, logos or the word "40%". So this skill builds an ad **template** once and **renders** it with Orshot, an API for automated image, PDF and video generation from templates. The price is real text, the logo is the real logo, and the 300th ad matches the first.

Writing ad copy is your job. Rendering it into pixel-exact ads in every size is Orshot's.

## What people ask for

- "Our Meta statics are fatiguing after a week. Make 10 new variations of our winning ad. Only the hook changes." (Refresh before the ad fatigues.)
- "Here's a product photo of the Tidewell bottle. Give me 15 static ad variations to test, feed and story sizes." (Product photo on a busy background, then Variants.)
- "I already make product scenes with an AI image model. Put our headline, price and logo on top so the text is never wrong."
- "Make catalog ads for every product in this Shopify store, with the sale price struck through when there is one." (Catalog and feed ads.)
- "I run Meta ads for six HVAC and roofing clients. Set up one ad template per client so I can push a new offer every week." (Agencies.)
- "Our recruiters at Hirebright send job details every day. Turn each one into a static job ad from our approved template in n8n."

## Where the facts live

This skill is the flow. Field shapes, allowed values and limits are in the docs. Read the page instead of guessing.

- Smart Resize over the API (`size`, `extraSizes`, preset list with sizes, response shape, limits): https://orshot.com/docs/api-reference/render-from-studio-template.md
- Smart Resize in the editor (adjust and save a size): https://orshot.com/docs/orshot-studio/smart-resize.md
- Style overrides per render (for example `opacity`): https://orshot.com/docs/orshot-studio/style-parameters.md
- Canvas background per render: https://orshot.com/docs/orshot-studio/api-specs.md
- Template JSON: the MCP resource `orshot://template-design-spec`, or https://orshot.com/docs/definitions/template-json.md
- Credits: https://orshot.com/docs/definitions/credits-usage.md
- Shopify app: https://orshot.com/docs/integrations/shopify.md
- Animated output (`videoOptions`): https://orshot.com/docs/video-generation/video-options.md
- Default size sets per campaign: `references/ad-sizes.md`
- Design craft (hierarchy, type, color, safe areas): load the `orshot-design` skill.

## Setup

1. Connect the hosted MCP server `https://mcp.orshot.com/mcp` (OAuth in the browser, no key). Client steps: https://orshot.com/docs/integrations/mcp-server.md. Scheduled jobs, n8n, Make, Zapier and server code use REST with `ORSHOT_API_KEY` (Workspace Settings > API Keys).
2. Confirm with `orshot_get_account`. A "plan limit" or "inactive subscription" reply is billing, not auth: send the user to https://orshot.com/pricing.
3. Get the brand: `orshot_get_brand_kit`. Empty and the user has a website? `orshot_scan_brand_website` with the URL, show what it found, and only after a yes call `orshot_import_brand_website`.

## The idea: one design, every size

Design the ad once at its main size. Render it with `extraSizes` and Smart Resize re-lays the same design out for each extra size in the same call. `size` replaces the main size; `extraSizes` adds copies. A value is a preset slug, a `"WIDTHxHEIGHT"` string or `{ width, height }`. Presets and limits: [Smart Resize](https://orshot.com/docs/api-reference/render-from-studio-template.md). Default sets for Meta, display and LinkedIn: `references/ad-sizes.md`.

Rules that keep Smart Resize honest:

- Pick the main size by where most spend goes. Meta-first campaigns design at 1080x1350. Display-first campaigns design at 300x250 or 1200x1200.
- Strip banners (728x90, 320x50, 970x250) have room for a logo, a 3 to 5 word headline and a CTA. Look at them before shipping. If one does not read, open the template's Smart Resize panel, use Adjust Variant on that size and save it: a saved size then renders exactly as arranged. A separate strip template is the other way out.
- `extraSizes` works for image formats only. Each extra size is billed as its own image.

## Ad anatomy and copy rules

Every ad has five parts. Make each one a dynamic field in the template:

| Part | parameterId | Rule |
|---|---|---|
| Hook / headline | `headline` | 3 to 6 words, the benefit, not the feature. "Sleep cooler tonight" beats "Phase-change fabric" |
| Offer | `offer` | One device: "40% OFF", "Free shipping", "2 for 1". In a badge, the biggest text after the product |
| Price | `price`, `old_price` | Real price from the user or the feed. `old_price` struck through, hidden with `"old_price.opacity": "0"` when there is no sale |
| CTA | `cta` | 1 to 3 words: "Shop now", "Get 40% off". Display ads need it on the image; Meta adds its own button, so hide it there |
| Logo | `logo` | Brand kit logo, small, one corner, always the same corner |
| Product | `product_image` | The product huge on a clean field, or a real photo of it in use. `objectFit: "cover"` for photos, `"contain"` for cut-outs |

Copy rules:

- Few words on the image. The ad's primary text and headline fields carry the long copy; the image carries the hook, the offer and the product. About 20 words on the image is a hard ceiling; 8 to 12 is better.
- One message per ad. A test changes one thing at a time.
- Numbers are digits: "40%", "$29", "3 days left".
- The hook goes in the top third and reads on its own, so it is the first thing seen. In Stories and Reels the bottom of the frame sits under the caption and buttons.
- Story placements: keep text, offer and logo out of the zones the platform UI covers. The safe areas are in `orshot://design-pack/social-media`, section 1.
- Contrast: white text on a photo needs a dark scrim (a gradient shape) under it.

## Build the template once

1. `orshot_list_studio_templates` with search `ad`. A good one exists? Read its keys with `orshot_get_studio_template_modifications` and skip to rendering.
2. Read `orshot://template-design-spec`, and load the `orshot-design` skill if the user has not fixed a look.
3. Find real imagery: the user's product shots from the brand kit, or `orshot_search_stock_media` with the subject in 1 to 3 words. Resolve a stock pick to a URL with `orshot_use_stock_media`, or put its `ref` straight into the template.
4. `orshot_create_template_design` named `Ad: <brand> <campaign type>`, `canvas_width: 1080`, `canvas_height: 1350`, `tags: ["ad"]`, `includeThumbnails: true`. Every part in the table above is `parameterizable: true` with its `parameterId`. Text layers get `textMode: "fit"` and a `minFontSize`. A seasonal background colour needs no field: send `canvasBackgroundColor` per render.
5. Read the thumbnail and the design checks. Fix real problems with one `orshot_update_template_design` call; small edits go through `orshot_patch_template_elements`.
6. Render once with all target sizes in `extraSizes` and look at every variant, the strips most of all, before any campaign run.

### Product photo on a busy background

Cut it out first: `orshot_render_library_template` with `templateId: "image-background-removal-api"`, `modifications: { "inputImage": "<photo URL>" }` and `format: "png"`. Check the fields with `orshot_get_library_template_modifications` if unsure. Use the result as `product_image` with `objectFit: "contain"`. It costs 1 AI credit per image, a separate pool from render credits ([Credits](https://orshot.com/docs/definitions/credits-usage.md)). Over REST it is `POST https://api.orshot.com/v1/generate/images` with the same `templateId` and `modifications` ([Render from a utility template](https://orshot.com/docs/api-reference/render-from-template.md)).

### Already making images with an AI model? Keep them, fix the text

Image models get prices, offers and small words wrong. Keep the user's generated image and send it as `product_image`, or as a full-bleed background image field. The template sets the headline, offer, price, CTA and logo as real text. The image URL must be public and must not expire (Gotchas).

### Rebuild a winning layout with the user's own assets

Start from the user's own past winner, or a screenshot of a layout they like. Note where the hook, product, offer and logo sit, and build that structure with the user's brand kit, product photos and words. Never copy another brand's logo, product shots, claims or copy, and do not scrape ad libraries for material.

### Agencies: one template per client

Each client gets its own template, tagged with the client name (`tags: ["ad", "<client>"]`), and every client template uses the same parameterIds. One automation then serves every client: it switches `templateId` and sends that client's row. Find a client's template with `orshot_list_studio_templates` and its tag.

## Render per campaign

Over MCP, `orshot_render_template` takes `templateId`, `modifications`, `format`, `size`, `extraSizes` and `fileName` as top-level arguments. Over REST the size fields go inside `response`:

```bash
curl -s -X POST https://api.orshot.com/v1/studio/render \
  -H "Authorization: Bearer $ORSHOT_API_KEY" -H "Content-Type: application/json" \
  -d '{
    "templateId": 123,
    "modifications": {
      "headline": "Sleep cooler tonight",
      "offer": "40% OFF",
      "price": "$89",
      "old_price": "$149",
      "cta": "Shop the sale",
      "product_image": "https://cdn.example.com/pillow.png",
      "cta.opacity": "0"
    },
    "response": {
      "type": "url", "format": "png",
      "fileName": "bf26_offer-40_v1_feed",
      "extraSizes": { "square": "instagram-post", "story": "instagram-story", "mrec": "medium-rectangle-ad" }
    }
  }'
```

`data.content` is the main ad. Each entry in `data.extraSizes` carries its own link in `content`. An entry with an `error` failed alone; the others are fine. Show the user every link.

The CTA is hidden for Meta in the example. For a display-only run, leave `cta` visible.

## Variants for testing

Test one variable at a time: headline angle, offer, or image. Write 3 to 5 options of that one field and keep the rest fixed.

- `orshot_batch_render_template` takes the `templateId`, a `renders` array of modification sets, and one shared `format`, `size` and `extraSizes`. Results come back in the same order as `renders`. Split large sets into several calls; the tool schema gives the per-call cap. Over REST, loop `POST /v1/studio/render`.
- Naming: `<campaign>_<variable>-<value>_v<n>_<size>`, for example `bf26_headline-sleep-cooler_v2_story`. Batch renders take no `fileName`, so keep a table of index, name, copy and URL, and hand it to the user with the links. Single renders take `fileName`.
- Cost before you send: variants x (1 + extra sizes). 5 headlines with 3 extra sizes is 20 images, 20 credits.
- After the test, make the winner's copy the template default with `orshot_patch_template_elements`, so future runs start from it.

### Refresh before the ad fatigues

Static ads wear out, so plan new variants on a schedule instead of waiting for results to drop.

- A sheet with one row per concept: the winning image, the offer and price, and a column of new hooks.
- Once a week, render the new hooks for each concept. Only the hook changes (or only the image). Name each file with the pattern above and write each URL back to its row.
- Run it where the user already automates (n8n, Make, Zapier or code), or as an Orshot Workflow draft (see Sheets, CSV and Airtable feeds below).
- Say the weekly cost first: hooks x (1 + extra sizes) credits per concept. 8 hooks with 2 extra sizes is 24 credits per concept a week.
- When a test ends, patch the winning hook into the template default as above.

## Catalog and feed ads: one render per product

For Meta Advantage+ catalog ads, Google Shopping-style display and any "every product, every size" job, each product is a set of modifications. Map the feed's columns (`title`, `price`, `sale_price`, `image_link`) to the template's fields, render one ad per product, and put each URL back next to its row.

Orshot renders the images and returns hosted URLs. It does not upload ads to Meta Ads Manager, Google Ads or LinkedIn Campaign Manager. The ad platform reads the image links from a feed.

**Shopify stores: use the Orshot Shopify app** ([docs](https://orshot.com/docs/integrations/shopify.md)).
- The user installs Orshot from the Shopify App Store. On the **Shopify** page in Orshot they pick "ad images", pick the template, and turn the workflow on for added or edited products, with a one-time run for the existing catalog.
- Name the template's fields with the Shopify parameter names in those docs and they fill from each product with no mapping. Any other template is mapped once on that page.
- Ad images go to Shopify Files and to an ads feed that Meta Commerce Manager and Google Merchant Center read as a supplementary feed. The product's main image is not replaced.
- Over MCP, `orshot_list_connected_integrations` shows whether Shopify is linked, and `orshot_list_workflow_nodes` lists the Shopify trigger (`shopify_new_product`) for a custom workflow.

**Sheets, CSV and Airtable feeds.** This is a recurring job, so set it up as automation:
- Check `orshot_list_workspace_logs` for the `source` the user already runs. n8n, Make, Zapier or their own code: add the render call there (on a schedule, read the feed, keep only changed rows, render, write the URL back).
- No orchestrator yet: Orshot Workflows. `orshot_list_workflow_nodes` returns the exact node keys, including Google Sheets, CSV and Airtable sources and a Google Sheets write-back step. Build with `orshot_create_workflow` as a draft and run it once with `orshot_run_workflow` after the user says yes.

For every feed:
- Sale logic lives in the feed step: when `sale_price` is lower, send `offer`, `price` and `old_price`; when it is not, send the price and `"old_price.opacity": "0"`.
- Re-render only changed rows. A 500-product catalog in 3 sizes is 1,500 credits per full pass.

## Animated banners (GIF and MP4)

For a short moving banner (a price that pops, a badge that pulses, 3 to 6 seconds), the same render tool takes `format: "gif"` or `"mp4"`. Longer video ads with footage, voiceover or scenes belong in the `orshot-video-generator` skill.

- GIF and MP4 need a plan with video rendering. The Free plan renders neither. Check `orshot_get_account` first.
- Add motion to the template (enter animations, `showAt`, `motion`; see [Template JSON](https://orshot.com/docs/definitions/template-json.md)). Frame 0 must already show the product and the offer.
- Check the layout with a still first: `format: "png"` with `responseType: "base64"` costs one image credit and shows the first frame. Then render the motion once.
- `videoOptions` sets `duration` and `fps` ([video options](https://orshot.com/docs/video-generation/video-options.md)). A lower fps makes a smaller GIF. GIF has no audio. Animated output is billed per second.
- `extraSizes` does not work for GIF or MP4. Render each animated size as its own call with `size` (for example `size: "medium-rectangle-ad"`, then `size: "320x50"`), and look at each one. A size saved in the Smart Resize panel renders as arranged.
- Display networks cap file size. Keep GIFs short, small and low on fps; check the network's limit before you upload.
- Long renders: pass `background: true` and collect with `orshot_get_render_job`.

## Gotchas

1. Modifications key by `parameterId`, never by layer name. Read `orshot_get_studio_template_modifications` first.
2. Style overrides like `"old_price.opacity"` only reach parameterized layers ([style parameters](https://orshot.com/docs/orshot-studio/style-parameters.md)).
3. Keep ad templates single page; sizes come from Smart Resize, not pages. On a multi-page template a key without a `pageN@` prefix reaches no page.
4. Image URLs must be public. Feed image links behind auth or signed links that expire fail the render.
5. Rendering does not run an ad. `orshot_render_template` can post organic content to connected social accounts with `publish`, but that is not a paid ad and is never the default.
6. A 9:16 variant made by Smart Resize keeps the 4:5 layout's logic. Check that the offer is not under the Story UI.
7. Do not make a new template per campaign. Swap the colour, offer and image fields instead.

## Safety

- Never invent a discount, price, deadline or review. Use the numbers the user or the feed gives you, and ask when one is missing.
- No fake scarcity ("only 2 left") unless the data says so. No competitor logos or trademarks without the user's say-so.
- Rebuild layouts only with the user's own brand, images and words. Never copy another brand's ad, and never scrape ad libraries.
- Say the credit cost before any batch over 10 renders and before any feed run, and wait for a yes.
- Show the first render of a new template before running a batch or a feed.
- Ask before importing anything into the brand kit.

Related skills: `orshot` (API, render options, automation), `orshot-design` (design craft rules), `orshot-social-media-content` (organic posts from the same brand), `orshot-carousel` (carousel ads and posts), `orshot-video-generator` (longer video ads), `orshot-social-media-scheduler` (posting organic content).
