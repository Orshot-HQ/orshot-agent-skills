---
description: Turn a topic, a blog post or a list into a multi-slide carousel for Instagram, LinkedIn or TikTok with Orshot.
argument-hint: "topic, blog post URL or list [platform, e.g. LinkedIn] [slides, e.g. 6]"
---

Make a carousel for the user with Orshot. Load the `orshot-carousel` skill first and follow its 6-slide formula, with `orshot-design` for the craft.

1. Read `$ARGUMENTS` for the source (a topic, a URL or pasted text), the platform and the number of slides. If no source was given, ask for it in one short question and nothing else. On-brand by default: the brand kit, or the user's website when they give one.
2. Defaults: 6 slides at 1080x1350. A cover hook that makes people swipe, one idea per slide with a drawn icon, photo or number that carries it, one visual system across every slide with a slide counter, and a last slide that asks for a save, a comment or a follow.
3. Write the slide copy from the source first (from a URL, read it and keep its real points). Plan with `orshot_plan_design`, create every slide in one `orshot_create_template_design` call with `includeThumbnails: true`, critique, then render every slide with `orshot_render_template`.
4. Show the slides in a table with their links. Offer one change round, a caption, and posting it with `/orshot:schedule-social-post`.

The first result is the demo, so hold it to this bar:
- Build a new design for this brief. Reuse an existing template only when the user names it or it was made earlier in this chat.
- Finished copy written for the subject, never placeholder words. Prices, discounts, quotes and claims come only from the user: where one is needed and missing, write a clearly sample value in a dynamic field and list it for the user to replace.
- Real pictures: the user's brand images or product photos first, otherwise stock photos or footage of the subject's world from `orshot_search_stock_media`. Never a flat empty frame.
- Only the user's own name, handle and logo, from the brand kit or their website. Never "Orshot", a name left over from another template, or a made-up brand.
- Look before you show: read the thumbnails and the design checks from the create, fix every concrete issue in one update, and only then render.

If no `orshot_*` tools are available, Orshot is not connected: ask the user to add the Orshot connector and sign in, then continue.
