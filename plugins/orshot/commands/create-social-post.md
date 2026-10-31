---
description: Make an on-brand social post (Instagram, LinkedIn, Facebook, X and more) with Orshot and show it in the chat.
argument-hint: "what the post is about [platform, e.g. Instagram] [sizes, e.g. feed and story]"
---

Make a social post for the user with Orshot. Load the `orshot-social-media-content` skill first and follow its flow, with `orshot-design` for the craft (shape, plan, gather, build in one call, critique).

1. Read `$ARGUMENTS` for the subject, the platform and the sizes. If no subject was given, ask for it in one short question and nothing else. On-brand by default: the brand kit, or the user's website when they give one.
2. Defaults: Instagram feed 1080x1350. One focal point, one key message, a format from `orshot_plan_design` that fits the job (not a centered text stack), two fonts, the brand colours, real copy written for the post.
3. Plan with `orshot_plan_design` (`job` in the user's words), create with `orshot_create_template_design` and `includeThumbnails: true`, critique, then render with `orshot_render_template`. For other sizes (a story, a LinkedIn or X size) render them in the same call and look at each one: if a size leaves an empty band, tiny text or a cropped subject, add a page laid out for that size, with the content filling the frame and the platform's safe areas clear.
4. Show every image with its link and the sample values to replace. Offer one change round, a caption, and posting it with `/orshot:schedule-social-post`.

The first result is the demo, so hold it to this bar:
- Build a new design for this brief. Reuse an existing template only when the user names it or it was made earlier in this chat.
- Finished copy written for the subject, never placeholder words. Prices, discounts, quotes and claims come only from the user: where one is needed and missing, write a clearly sample value in a dynamic field and list it for the user to replace.
- Real pictures: the user's brand images or product photos first, otherwise stock photos or footage of the subject's world from `orshot_search_stock_media`. Never a flat empty frame.
- Only the user's own name, handle and logo, from the brand kit or their website. Never "Orshot", a name left over from another template, or a made-up brand.
- Look before you show: read the thumbnails and the design checks from the create, fix every concrete issue in one update, and only then render.

If no `orshot_*` tools are available, Orshot is not connected: ask the user to add the Orshot connector and sign in, then continue.
