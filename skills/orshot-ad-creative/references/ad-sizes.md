# Default ad size sets

Starting sets per campaign type. Each value goes in `size` or `extraSizes` on a render. Orshot's preset slugs and their pixel sizes, plus the rules for custom `"WIDTHxHEIGHT"` values, are in the docs: https://orshot.com/docs/api-reference/render-from-studio-template.md (Smart Resize section). Credits per output: https://orshot.com/docs/definitions/credits-usage.md.

Ad platforms change their specs. Check the platform's help page before a large campaign.

## Meta (Facebook and Instagram)

Design at 1080x1350 (4:5 feed). Add the square and the story:

```json
"extraSizes": { "square": "instagram-post", "story": "instagram-story" }
```

Add `"link": "facebook-post"` when the campaign runs link-style placements. For catalog ads, the square is the safe main image.

## Google display

Design at 300x250 (`medium-rectangle-ad`). Add the common display sizes:

```json
"extraSizes": ["leaderboard-ad", "300x600", "320x50", "336x280"]
```

Add `"160x600"`, `"970x250"`, `"970x90"` or `"320x100"` when the buy needs them. Render with `scale: 2` for crisp text on retina screens, then check the network's file size limit.

The strips (728x90, 970x90, 320x50, 970x250) hold a logo, 3 to 5 words and a CTA. If a strip made from a square design does not read, adjust that size in the Studio Smart Resize panel and save it (https://orshot.com/docs/orshot-studio/smart-resize.md), or keep a separate strip template.

## Google responsive display (uploaded assets)

Design at 1200x1200. Add the landscape image:

```json
"extraSizes": ["1200x628"]
```

Google assembles these with your text, so keep words on the images to a minimum.

## LinkedIn

Design at 1200x1200. Add the landscape and the vertical:

```json
"extraSizes": ["linkedin-post", "720x900"]
```

## Other placements people ask for

- X (Twitter) image ad: `twitter-post`
- Pinterest: `pinterest-pin`
- Email header banner: `email-header`, rendered with `scale: 2`
- Website hero banner: `website-banner`
- TikTok in-feed is video only: use the `orshot-video-generator` skill.
