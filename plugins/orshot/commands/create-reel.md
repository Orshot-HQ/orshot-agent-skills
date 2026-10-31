---
description: Make a short vertical video (Reel, TikTok or Short) with Orshot, with music and captions, and show it in the chat.
argument-hint: "topic or product [length, e.g. 15s] [platform, e.g. TikTok]"
---

Make a short video for the user with Orshot. Load the `orshot-video-generator` skill first and follow its steps in order (beat sheet, the look, pacing, check before any render, render once). It brings in `orshot-design` for the craft.

1. Read `$ARGUMENTS` for the topic or product, the length and the platform. If no topic was given, ask for it in one short question and nothing else. On-brand by default: the brand kit, or the user's website when they give one.
2. Defaults: 15 seconds (or the length asked), 1080x1920, a film of 3 to 5 scenes. The hook is on screen in the first second, every scene has footage or a photo of the subject under the type, one idea per scene acted out (a number counts, a line draws), one cut family, a music bed from Orshot's library and a sound cue where something lands. Pacing wins over the target length: if every word needs more time, say how long it runs and why.
3. Plan with `orshot_plan_design` (`job` in the user's words, `duration_seconds`), then create the whole film in one `orshot_create_template_design` call with `includeThumbnails: true`. Before the MP4, read the film and design checks and the storyboard (`orshot_get_studio_template` with `storyboard: true`), fix real issues in one update, then render once with `orshot_render_template` and follow the job with `orshot_get_render_job`.
4. Show the video link with one line per scene and the sample values to replace. Offer one change round, a second size (square or 4:5), and posting it with `/orshot:schedule-social-post`. Do not look up social accounts or post before the user has seen the render.

The first result is the demo, so hold it to this bar:
- Build a new design for this brief. Reuse an existing template only when the user names it or it was made earlier in this chat.
- Finished copy written for the subject, never placeholder words. Prices, discounts, quotes and claims come only from the user: where one is needed and missing, write a clearly sample value in a dynamic field and list it for the user to replace.
- Real pictures: the user's brand images or product photos first, otherwise stock photos or footage of the subject's world from `orshot_search_stock_media`. Never a flat empty frame.
- Only the user's own name, handle and logo, from the brand kit or their website. Never "Orshot", a name left over from another template, or a made-up brand.
- Look before you show: read the thumbnails and the design checks from the create, fix every concrete issue in one update, and only then render.

If no `orshot_*` tools are available, Orshot is not connected: ask the user to add the Orshot connector and sign in, then continue.
