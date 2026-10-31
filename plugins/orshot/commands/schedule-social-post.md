---
description: Post or schedule a render to your social accounts with Orshot (Instagram, TikTok, LinkedIn, Facebook, YouTube, X, Threads, Pinterest and more).
argument-hint: "what to post [platforms] [when, e.g. Tuesday 9am, or now]"
---

Post or schedule a social post for the user with Orshot. Follow the `orshot-social-media-scheduler` skill.

1. Start from a template, always. Read `$ARGUMENTS` for what to post, the platforms and the time. Use a template rendered earlier in this chat or one the user names; otherwise make it first by following `/orshot:create-social-post`, `/orshot:create-reel` or `/orshot:create-carousel` in full (a new design for this brief, held to that command's bar). Photos or clips the user gives go into the template's image or video field, never straight into a post. Render it and show the user before anything else.
2. Only now check the connected accounts with `orshot_list_social_accounts`. If a platform has no account, save the post as a draft anyway and say it waits in Orshot until that account is connected.
3. Write a caption for each platform. Use `orshot_get_best_time_to_post` when the user gave no time.
4. Before anything goes out, show the user the media, the captions, the accounts and the time, and wait for their yes. Then publish or schedule with `orshot_publish_social_post`.
5. Report what was scheduled, where and when, with the post link.

If no `orshot_*` tools are available, Orshot is not connected: ask the user to add the Orshot connector and sign in, then continue.
