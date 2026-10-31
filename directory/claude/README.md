# Orshot for Claude

**Works with the Orshot connector.** Installing this plugin adds the skills. To let them design, render and post, also add the Orshot connector: in Claude open Customize, then Connectors or Plugins, search Orshot, select Connect, and sign in. A free Orshot account works.

Orshot is an API for automated image, PDF and video generation from templates. This plugin adds Orshot skills to Claude: design a template, render it as a video, image or PDF, and post or schedule it to connected social accounts. The skills cover videos and reels, social posts, carousels, ad creatives, blog images, YouTube thumbnails and PDFs.

## Commands

- `/orshot:create-reel` makes a short vertical video with music and captions.
- `/orshot:create-social-post` makes an on-brand post for Instagram, LinkedIn, Facebook, X and more.
- `/orshot:create-carousel` turns a topic, blog post or list into slides.
- `/orshot:schedule-social-post` posts or schedules a render to your connected accounts, after you confirm.

You can also just ask, for example "make a 15-second TikTok about our new menu", and the skills take over.

## Connect

The plugin uses the hosted Orshot MCP server at `https://mcp.orshot.com/mcp`. You sign in with your Orshot account through OAuth in the browser. No API key is needed. A free account works; paid plans add more renders and features (https://orshot.com/pricing).

## What the plugin runs and fetches

Nothing runs locally: no scripts, hooks or binaries. The skills are instructions and reference files. The only service they use is the Orshot MCP server at `https://mcp.orshot.com/mcp`, through the connector above. Designs can include image URLs (brand logos, icons, stock media) that Orshot's renderer loads when it renders.

## Data sent to Orshot

When you ask for a design or a render, Claude sends Orshot the text, sizes and settings for that design, and any images, video or audio you give it or choose from stock. Orshot stores templates, renders and brand assets in your own workspace. Posting sends the render and caption to the social accounts you connected in Orshot, and only after you say yes. Privacy policy: https://orshot.com/privacy. Terms: https://orshot.com/terms.

## Support

https://orshot.com/contact or hi@orshot.com. Docs: https://orshot.com/docs/integrations/mcp-server.
