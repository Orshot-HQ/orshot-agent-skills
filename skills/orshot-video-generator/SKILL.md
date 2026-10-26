---
name: orshot-video-generator
description: "Faceless video and YouTube Shorts maker with Orshot: faceless Shorts, Reels and TikTok videos, captioned talking-head clips, product and launch videos, explainers, podcast clips and short video ads, rendered to MP4 from a video template with word-by-word captions, stock footage, voiceover and music, by hand or on a schedule from n8n, Make, Zapier or cron. Use when: \"automate my faceless YouTube channel\", \"make a faceless short every day\", \"turn this script into a short with captions\", \"add auto captions to my reels\", \"make a launch video for my app\", \"make a 15 second video ad\", \"n8n video automation\", \"short video maker\". NOT for photo carousels or TikTok photo-mode slideshows (use orshot-carousel; a slideshow rendered as one MP4 with a song stays here), YouTube thumbnails (use orshot-youtube-thumbnail), static ads or short animated banners (use orshot-ad-creative) or scheduling posts (use orshot-social-media-scheduler)."
homepage: https://orshot.com/agents/skills/video-generator
license: MIT-0
metadata:
  author: Orshot
  version: "1.0.0"
  openclaw:
    emoji: "🎬"
    homepage: https://orshot.com/agents/skills/video-generator
    primaryEnv: ORSHOT_API_KEY
    requires:
      env: []
      bins: []
    envVars:
      - name: ORSHOT_API_KEY
        required: false
        description: Orshot API key. Only for REST and scheduled jobs. Not needed over the hosted MCP server with OAuth.
---

# Orshot Video Generator: faceless Shorts, reels and launch videos from one template

A reel, a Short or a TikTok is the same video every time with new words, new clips and a new voiceover. That is a template render. An Orshot video template holds the layout, fonts, motion, captions and soundtrack. Each video sends only its own text and media URLs and gets an MP4 back.

This is not a model that invents footage. You write the script and pick real stock clips or the user's own media. Orshot renders them through the template the same way every time. Captions come from the audio you supply. The template stays editable in Orshot Studio, so someone who does not code can change a line, a clip or a color later.

## What people ask for

- "Build me a faceless YouTube Shorts pipeline: every morning take the next row in my sheet, make a 30 second fact short with stock clips and captions, and save it as a draft." (Faceless fact reel, then the n8n pipeline in Step 4.)
- "Here's the script and the voiceover mp3. Turn it into a short with word-by-word captions and b-roll."
- "We film talking-head clips at Lindale Physio. Add burnt-in captions and our logo bar to each one, 9:16, same look every time." (Captions on an existing clip.)
- "Make a 30 second launch video for Tallyhop from our website: logo, three screenshots, one line each, end on the signup link." (Launch or product video.)
- "Our brand needs 2 to 3 reels a day. Set up n8n so every new script in Airtable renders a captioned reel and posts it as a draft."
- "Make a 15 second video ad for the Brightloom desk lamp for Reels and TikTok, hook in the first second." (Short video ad.)

## Where the facts live

This skill is the flow. Field shapes, allowed values and limits are in the docs. Read the page instead of guessing.

- Template JSON (pages, elements, animation, audio, subtitles): the MCP resource `orshot://template-design-spec`, or https://orshot.com/docs/definitions/template-json.md
- Formats and how video rendering works: https://orshot.com/docs/video-generation.md
- Render-time `videoOptions` (fps, trim, audio swap, captions, page transitions): https://orshot.com/docs/video-generation/video-options.md
- Captions and caption presets: https://orshot.com/docs/video-generation/adding-subtitles.md
- Per-render clip keys (trim, mute, loop): https://orshot.com/docs/video-generation/video-elements.md
- Animation and motion: https://orshot.com/docs/orshot-studio/animations.md and https://orshot.com/docs/orshot-studio/motion.md
- Credits: https://orshot.com/docs/definitions/credits-usage.md
- Async jobs over REST: https://orshot.com/docs/api-reference/async-render-start.md
- Design craft (hierarchy, type, color, safe areas): load the `orshot-design` skill.

## What you get

| Format | Size | Use |
|---|---|---|
| 9:16 vertical | 1080x1920 | Reels, Shorts, TikTok, Stories, faceless channels |
| 1:1 square | 1080x1080 | feed video, product loops |
| 16:9 landscape | 1920x1080 | explainers, YouTube, landing pages |

One page holds one scene. Longer videos use one page per scene, joined into one file with `videoOptions.combinePages`.

**Video needs a plan with video rendering.** The Free plan renders no video format, GIF included ([Video on Free Plan](https://orshot.com/docs/error-reference.md)). `orshot_get_account` shows whether video rendering is on the plan. On a plan without it, the create and update results still link a free animated preview of the motion and flag `videoLocked`, so the user can see the design before upgrading.

## Setup

1. Connect the hosted MCP server `https://mcp.orshot.com/mcp` (OAuth in the browser, no key). Client steps: https://orshot.com/docs/integrations/mcp-server.md. Scheduled jobs use REST with `ORSHOT_API_KEY` (Workspace Settings > API Keys).
2. `orshot_get_account`: confirm the workspace and that video rendering is included.
3. `orshot_get_brand_kit` for on-brand work: colors, fonts, logo, brand videos and brand audio.
4. Read `orshot://template-design-spec` once before the first create.

## Pick the video type

Each recipe is one template, built once. Text and media fields are dynamic (`parameterizable: true` with a `parameterId`), so every new video is a render, not a redesign.

**Faceless fact reel (9:16, 20 to 40 s).** 5 to 7 pages, 4 to 6 s each.
- Page 1 hook: the claim at t=0, biggest text, a full-bleed clip of the subject. "Octopuses have three hearts" beats "Did you know?".
- Pages 2 to 5: one fact per page, 6 words or fewer per line, a new clip per page.
- Last page: the payoff and a follow line.
- Fields: `pageN@line`, `pageN@clip`. Music from brand audio, or a voiceover file with captions.

**Product reel (9:16 or 1:1, 15 to 25 s).** 4 pages.
- Hook (the product in use or the result), 2 feature pages (product photo or clip plus one line each), price and CTA.
- Fields: `pageN@headline`, `pageN@product_image` or `pageN@clip`, `page4@price`, `page4@cta`.
- Full-bleed product photos get a `kenBurns` ambient so they read as footage.

**Launch or product video (16:9 or 9:16, 30 to 45 s).** 5 to 7 pages.
- Page 1: the problem or the result in one line at t=0, with the product on screen.
- One feature per page: a real screenshot or screen recording in a card or device frame, plus one line of 6 words or fewer.
- Last page: the logo, the promise and the URL.
- Fields: `pageN@headline`, `pageN@screen` (image) or `pageN@clip` (video), and `pageN@cta` on the last page.
- Screenshots, recordings and the logo come from the user. The brand comes from `orshot_get_brand_kit`. Empty kit and a website? `orshot_scan_brand_website`, show what it found, and call `orshot_import_brand_website` only after a yes. No screenshot yet? `orshot_render_library_template` with `templateId: "website-screenshot"` captures a page.
- Keep the template for the next launch: only the lines and screens change.

**Short video ad (9:16, 10 to 15 s).** 3 pages.
- Page 1: the hook at t=0 in the top third, over a clip of the product. Keep words out of the zones the platform UI covers.
- Page 2: the product in use and one benefit.
- Page 3: the offer and the CTA, with real prices from the user.
- Fields: `page1@hook`, `page1@clip`, `page2@line`, `page2@clip`, `page3@offer`, `page3@cta`.
- Test variants change only `page1@hook`. Static ads and short GIF banners belong to the `orshot-ad-creative` skill.
- A second size (16:9 for the launch video, 4:5 for a feed ad): save that size in the template's Smart Resize panel and render it with `size`. A saved size renders exactly as arranged ([Smart Resize](https://orshot.com/docs/orshot-studio/smart-resize.md)). Look at it before using it.

**Explainer (16:9, 30 to 90 s).** One page per step, 5 to 10 pages.
- Start where the viewer is, then one concrete example worked start to finish. One idea per page. A list or diagram grows one part per beat.
- A voiceover drives it. Captions on, with a calm preset such as `minimal`.

**Podcast or quote clip (9:16 or 1:1, 15 to 60 s).** One page.
- The speaker photo or clip, the show name, the quote or captions, and a `waveform` layer that animates from a page audio track (Waveforms in [Template JSON](https://orshot.com/docs/definitions/template-json.md)).
- Fields: `quote`, `speaker_name`, `speaker_photo`. Swap the audio per render with `videoOptions.audioSource`; captions come from the same audio.

**Captions on an existing clip (any size).** One page with a full-bleed video field (element `videoOptions.muted: false` so the clip keeps its sound) plus a logo or title bar. Per render: the clip URL in the field and the same URL in `videoOptions.subtitleSource`, with a `captionPreset`. A video URL is transcribed from its own audio ([Adding subtitles](https://orshot.com/docs/video-generation/adding-subtitles.md)).

```json
{
  "templateId": 123,
  "format": "mp4",
  "background": true,
  "modifications": {
    "clip": "https://.../take-07.mp4",
    "title": "3 signs you grind your teeth"
  },
  "videoOptions": { "subtitleSource": "https://.../take-07.mp4", "captionPreset": "bold" }
}
```

Send the same `captionPreset` on every clip so the series looks the same. Orshot captions and frames the clip. It does not cut silences or retakes, so trim the clip first.

## Footage, music and captions

- **Stock video:** `orshot_search_stock_media` with `type: "video"`, `orientation: "vertical"` for 9:16, and a 1 to 3 word query ("octopus", "espresso pour"). In a template, put the result's `ref` (`stock://pixabay/video/<id>`) as the video element's `content`; Orshot re-hosts it on save. For a render modification, resolve it first with `orshot_use_stock_media` and pass the returned `url`. Never use `previewUrl`; it expires.
- **The user's own media:** `orshot_get_brand_videos`, `orshot_get_brand_audio`, or any public URL. Upload new files with `orshot_upload_brand_video` and `orshot_upload_brand_audio`.
- **Music:** a page audio track with its trim, fade, volume and loop saved in the template. Swap the file per render with `videoOptions.audioSource`; the saved trim, fade and volume stay.
- **How many tracks:** a template can hold more audio tracks than a render may use. A render is refused when a page has more tracks than the plan allows per page (Page audio in [Template JSON](https://orshot.com/docs/definitions/template-json.md)). Voice plus music is two tracks. If the plan allows one, mix them into one file first.
- **Voiceover:** a recorded file as a page audio track. Some clients also offer generated narration: if `orshot_get_audio_authoring_options` is in your tool list, call it for voices and limits. If it is not, use a recorded file.
- **Auto captions:** set `page.subtitle.source: "auto-audio"` in the template to caption the page's first audio track, or pass `videoOptions.subtitleSource` per render. Pick the look with `videoOptions.captionPreset`. Presets and styling keys: [Adding subtitles](https://orshot.com/docs/video-generation/adding-subtitles.md).

## Step 1. Build the template once

1. Look for one first: `orshot_list_studio_templates` with a search like "reel" or "shorts". Reuse it if it fits.
2. Search stock clips per scene (above) before designing.
3. `orshot_create_template_design` with `name`, `canvas_width` and `canvas_height` set to the format, every page in `pages_data`, and `includeThumbnails: true`. Per page: `canvas`, `elements`, `videoDuration`, plus `audioTracks` and `subtitle` where needed. Per element: `transitions` or `motion`. Field shapes: [Template JSON](https://orshot.com/docs/definitions/template-json.md).
4. Read the result: the thumbnails, any "Design checks" and "Param warnings" (a warned param does nothing), and the animated preview link. Fix real problems in one `orshot_update_template_design` call. Small edits later go through `orshot_patch_template_elements`.

Worked example, one scene of a 9:16 fact reel. Copy the page per fact, change the clip, and vary the entrance.

```json
{
  "name": "Fact Reel 9:16",
  "canvas_width": 1080,
  "canvas_height": 1920,
  "tags": ["video", "reel"],
  "includeThumbnails": true,
  "pages_data": [
    {
      "name": "Hook",
      "canvas": { "width": 1080, "height": 1920, "backgroundColor": "#111111" },
      "videoDuration": 5,
      "audioTracks": [
        { "url": "https://.../track.mp3", "trimStart": 30, "trimEnd": 60, "fadeOut": 1, "volume": 1, "loop": true }
      ],
      "elements": [
        {
          "id": "clip", "type": "video", "content": "stock://pixabay/video/<id>",
          "position": { "x": 0, "y": 0 }, "dimensions": { "width": 1080, "height": 1920 },
          "style": { "objectFit": "cover" },
          "videoOptions": { "loop": true, "muted": true },
          "parameterizable": true, "parameterId": "clip", "parameterType": "videoUrl", "zIndex": 1
        },
        {
          "id": "scrim", "type": "shape", "shapeType": "rectangle",
          "position": { "x": 0, "y": 0 }, "dimensions": { "width": 1080, "height": 1920 },
          "style": { "fill": "linear-gradient(180deg, rgba(0,0,0,0.15) 0%, rgba(0,0,0,0.55) 100%)" },
          "zIndex": 2
        },
        {
          "id": "line", "type": "text", "content": "Octopuses have three hearts",
          "position": { "x": 90, "y": 640 }, "dimensions": { "width": 900, "height": 420 },
          "style": {
            "fontFamily": "Inter", "fontSize": "88px", "fontWeight": "900", "color": "#FFFFFF",
            "textAlign": "center", "lineHeight": 1.1, "textMode": "fit", "minFontSize": "48"
          },
          "transitions": {
            "enter": { "type": "textReveal", "duration": 0.3, "easing": "ease-out", "customValues": { "granularity": "word" } },
            "showAt": 0
          },
          "parameterizable": true, "parameterId": "line", "parameterType": "text", "zIndex": 3
        }
      ]
    }
  ]
}
```

Motion rules that make it look edited, not generated:
- Frame 0 is the hook: the hero and the first line are on screen at t=0, with no enter or a very short one.
- Every full-bleed photo gets `ambient: { "type": "kenBurns", "customValues": { "zoom": 1.1, "panX": 6 } }`; flip `panX` on the next page.
- Titles land and hold still. No looping ambient on text or buttons.
- One page transition for the whole video.
- On 9:16, keep words out of the zones the platform UI covers. The safe areas are in `orshot://design-pack/social-media`, section 1.

## Step 2. Check a still before spending a video render

A video render often takes a minute or more and costs a credit per second. The first frame shows layout, contrast and text fit exactly as the video will. Check it as a still first:

```
orshot_render_template  templateId: 123, format: "png", includePages: [1], responseType: "base64",
                        modifications: { "page1@line": "Octopuses have three hearts" }
```

One image credit. Look at it, fix what is wrong, then render the video once. For motion, watch the animated preview from the create or update result, or use Preview Animation in the editor. Never render an MP4 to see where a layer sits.

## Step 3. Render the video

Get the exact keys first: `orshot_get_studio_template_modifications`. Then over MCP:

```json
{
  "templateId": 123,
  "format": "mp4",
  "background": true,
  "modifications": {
    "page1@line": "Octopuses have three hearts",
    "page1@clip": "https://.../octopus.mp4",
    "page2@line": "Two pump blood to the gills",
    "page2@clip": "https://.../gills.mp4"
  },
  "videoOptions": {
    "combinePages": true,
    "pageTransition": "smoothleft",
    "pageTransitionDuration": 0.4,
    "audioSource": "https://.../track.mp3"
  }
}
```

With `background: true` the call returns a `jobId` at once. Collect it with `orshot_get_render_job` (`id`, `waitSeconds: 25`) and call again while `finished` is false. If a render without `background` times out on your side, it still finishes on the server: find the URL with `orshot_list_workspace_logs` instead of rendering again.

Per-render tuning without editing the template, for example `"page1@clip.trimStart": 2`, `"page2@line.showAt": 0.6` or `"page2@line.enterType": "scaleIn"`. The full key list is in [Video elements](https://orshot.com/docs/video-generation/video-elements.md) and the API usage section of [Animations](https://orshot.com/docs/orshot-studio/animations.md).

## Step 4. Many videos from rows

`orshot_batch_render_template` renders images and PDFs only. For videos, loop `orshot_render_template` with `background: true`, one call per row, then collect each `jobId`. Say the total credit cost before starting (a 30 s video is 30 credits).

For a recurring channel (a new fact reel every day, a product reel per new product), put the REST call into what the user already runs. Check `orshot_list_workspace_logs` for their `source` and add to that: [n8n](https://orshot.com/docs/integrations/n8n.md), [Make](https://orshot.com/docs/integrations/make.md), [Zapier](https://orshot.com/docs/integrations/zapier.md) or their own code.

```bash
curl -s -X POST https://api.orshot.com/v1/studio/render \
  -H "Authorization: Bearer $ORSHOT_API_KEY" -H "Content-Type: application/json" \
  -d '{
    "templateId": 123,
    "modifications": {
      "page1@line": "{{row.hook}}",
      "page1@clip": "{{row.clip_url}}",
      "page2@line": "{{row.fact_1}}"
    },
    "videoOptions": { "combinePages": true, "pageTransition": "smoothleft", "audioSource": "{{row.music_url}}" },
    "response": { "type": "url", "format": "mp4", "mode": "async" }
  }'
# returns a job with an id; poll it until finished is true:
curl -s https://api.orshot.com/v1/studio/render-jobs/<id> -H "Authorization: Bearer $ORSHOT_API_KEY"
```

Use async for every video from Zapier, Make or n8n: a sync video render can outlive their HTTP timeouts.

### A faceless Shorts channel in n8n

One template per channel, one n8n node per step:

1. **Schedule Trigger:** once a day.
2. **Google Sheets:** read the next row marked `todo`. It holds the topic and one clip URL per scene. Stock search is an MCP tool, so fill the clip columns ahead with `orshot_search_stock_media` and `orshot_use_stock_media`, or use the user's own brand videos.
3. **LLM node:** write the hook, one on-screen line per scene (6 words or fewer) and the narration per scene. Each scene's narration must fit its page length (Gotchas, narration budget).
4. **Text to speech:** one mp3 per scene from the user's voice service, at a public URL.
5. **HTTP Request:** the async render below. The Orshot n8n node lists image and PDF formats, so video goes through an HTTP Request node ([n8n](https://orshot.com/docs/integrations/n8n.md)).
6. **Wait for the result:** send `webhook_url` pointing at an n8n Webhook node, or poll `GET /v1/studio/render-jobs/<id>` until `finished` is true ([Async renders](https://orshot.com/docs/api-reference/async-render-start.md)).
7. **Write back:** put the video URL in the row and mark it `done`, or add `publish` with `"isDraft": true` so it waits as a draft (Step 5).

```json
{
  "templateId": 123,
  "modifications": {
    "page1@line": "{{hook}}", "page1@clip": "{{clip_1}}",
    "page2@line": "{{line_2}}", "page2@clip": "{{clip_2}}"
  },
  "videoOptions": {
    "combinePages": true,
    "pageTransition": "fade",
    "audioSource": [ { "page": 1, "url": "{{voice_1}}" }, { "page": 2, "url": "{{voice_2}}" } ],
    "subtitleSource": [ { "page": 1, "url": "{{voice_1}}" }, { "page": 2, "url": "{{voice_2}}" } ],
    "captionPreset": "bold"
  },
  "response": { "type": "url", "format": "mp4", "mode": "async" },
  "webhook_url": "https://<your-n8n>/webhook/orshot-done",
  "metadata": "{{row_number}}"
}
```

Each `audioSource` entry swaps track 0 of its page, so the voice is track 0 and any music is track 1 (if the plan allows two tracks per page). `metadata` comes back with the job, so the Webhook node knows which row to update.

Say the cost before switching it on. Video is 1 credit per second ([Credits](https://orshot.com/docs/definitions/credits-usage.md)), so one 30 s short a day is 30 credits a day, about 900 a month.

## Step 5. Post it as a draft

Add `publish` to the render. Over MCP:

```json
"publish": { "accounts": [7, 9], "content": "Octopuses have three hearts. Follow for one fact a day. #facts", "status": "draft" }
```

Over REST the render endpoint reads `"isDraft": true` instead of `status` ([Publish from the API](https://orshot.com/docs/publish/publish-from-api.md)). Get account ids from `orshot_list_social_accounts`. Show the draft with `orshot_get_social_post`; after the user approves, `orshot_publish_social_draft`, or schedule it with `orshot_update_social_post`. Which platforms take video: [Posting guidelines](https://orshot.com/docs/publish/social-posting-guidelines.md). Connecting accounts is a paid add-on ([pricing](https://orshot.com/docs/publish/pricing.md)). Scheduling, best time and analytics: the `orshot-social-media-scheduler` skill.

## Gotchas

1. On a multi-page template, a content key without a `pageN@` prefix reaches no page. Send `page1@line`, `page2@line` and so on ([Multi-page templates](https://orshot.com/docs/image-generation/multi-page-images.md)).
2. `showAt` and `hideAt` sit next to `enter` and `exit` inside `transitions`, never inside `enter`. This is the most common authoring bug.
3. Set `canvas_width` and `canvas_height` on create. The defaults are not a video size.
4. Over MCP, `easing` takes only the values the schema lists (named easings, one bounce curve, `spring(...)`). Any other `cubic-bezier(...)` is rejected.
5. `trimStart` and `trimEnd` in `videoOptions` trim the output, not the music, and must be sent together. Trim a song on its audio track instead.
6. `audioSource` as a string swaps each page's first audio track. To swap only the voice and keep the music, use the array form with `page` and `track`.
7. Templates with `page.subtitle.source: "auto-audio"` need no `subtitleSource`.
8. A shape is painted by `style.fill`. Without it the shape renders black.
9. Media URLs must be public. Stock `previewUrl`, localhost and expiring signed links fail.
10. Narration budget: about 2 words per second plus 1 s of headroom per page.

## Safety

- Never publish without the user watching the video. Use `status: "draft"` (MCP) or `isDraft: true` (REST) until they approve.
- Confirm the accounts and caption before posting.
- Say the credit cost before rendering more than 3 videos or anything over 60 s.
- Use only footage the user owns or stock from `orshot_search_stock_media`. Real people speak only in audio the user supplied, with their consent.

Related skills: `orshot` (API, render options, automation), `orshot-design` (design craft), `orshot-carousel` (photo carousels and slideshows), `orshot-ad-creative` (static and animated ads), `orshot-youtube-thumbnail` (the thumbnail for the Short or video), `orshot-social-media-scheduler` (scheduling and analytics).
