# Video post formats brands actually run

Built from 46 short videos that brands, clubs, venues and product teams posted in 2026 (15 Instagram Reels, 15 product videos on X and LinkedIn, 16 motion design showcases), each recorded frame by frame with timings, and a comparison of the 20 most viewed and 17 least viewed designed Reels on 7 brand accounts. These are the video versions of the post types in the `orshot-social-media-content` skill's formats file (event, launch, match day, stat, speaker, listing, menu and quote), plus a carousel and an ad as video. Load the paired skill with this one: it designs the static post that the film ends on; this file says how the film builds to it. Each format is one film template a brand posts again and again with new content.

Field shapes, motion keys and transition types live in `orshot://film-spec`, `orshot://template-design-spec` and https://orshot.com/docs/orshot-studio/motion.md. This file says what to build and when things happen. Times count from each scene's start.

## What the strong videos have in common

1. **The film ends on the post, laid out again for the video's frame.** The last scene is the static post for that type (the place-and-date card, the changelog card, the edge rail, the row table) and it holds. Everything before it builds to it. The last frame works as a cover and as a screenshot, and the brand's image posts and video posts match. Never paste a 4:5 card into a 9:16 frame: re-lay it so the photo or ground fills the whole frame and the type grows with it. Keep the image template's field names as the base of the film's keys: a film's keys carry the scene's page (`page2@event_name`), and a picture shown on two scenes is two keys (`page1@photo`, `page2@photo`), so a sheet column maps to every key that uses it.
2. **Fill the frame.** The photo, the ground colour or the drawn part runs to every edge on every scene, the platform's UI zones included; only text stays inside the safe band. The hero (the word, the number, the component, the chart) fills 40% or more of the frame. An empty lower third or a small card floating in the middle reads as unfinished. On 9:16, the headline is at least 7% of the frame height and meta lines at least 2.2%.
3. **Frame 0 is the subject.** The photo, the component, the number or the layout is on screen at frame 0, or the first word lands by 0.5 s. Opening on an empty colour for a second loses the scroll.
4. **Build fast, hold long.** A card builds in about 1.5 s (rows land 0.1 s apart, the title reveals by word) and then holds for as long as reading takes: 7 to 11 s for a list. A long hold is right when there is a lot to read; a short hold under a lot of words is the most common failure.
5. **Something always moves, one thing at a time.** No frame of the film is a still. Every scene has a slow camera push (the photo, or the whole scene, scaling about 1.0 to 1.05 over its length). Once a scene is built, one more thing keeps moving during the hold: a ticker, a light sweep, a drawn line, a pair of digits, a pill that lands late (`Sent`, `4 seats left`). The type never re-animates. A slam word moves too: it arrives scaling down from about 1.3 with a blur that clears in 0.4 s, not by appearing.
6. **Numbers move.** A score, a price, a stat or a count rolls, counts or draws. A static number in a video is a missed beat.
7. **Something is drawn.** Each format has one drawn SVG part that animates: a crest or rail that builds, a chart line, spec icons that draw stroke by stroke, a marker under the key phrase, a circle around the date. It is what separates an edited film from a photo with text sliding in.
8. **The word or the brand device is the transition.** The strongest cuts come out of the content: the camera zooms through the shout word (`zoomThrough`), the score card grows into the next scene (`grow`), the number travels into the end card (`match`). Between scenes that keep one grid, a `push` or `wipe`. A slam beat can be a hard cut with a flash overlay. No crossfades between content scenes. One continuity cut per film, usually the cut into the final post.
9. **Fixed chrome, changing content.** The logo, the meta labels and a progress rail stay put across every cut, as one `layers` track, while the content changes.
10. **Two typefaces, contrast by role.** A heavy display face for the shout or the number, a condensed, serif or mono face for names and meta. Headline type at least 6% of the frame height.
11. **8 to 20 seconds.** Long montages only work for brands with an audience. The reusable post is the first 8 to 20 s.

All of it stays inside the pacing rule in the skill: about 0.4 s per word from when each block starts entering, then a 1 s hold before the cut, the last arrival holding 2 s or more, draws of 2 to 3 s, transitions of 0.9 to 1.2 s. The scene lengths below are for typical copy; when the real copy is longer, the scene gets longer, and the hold gets one more thing that moves.

## Basics every film gets

From platform research (Meta, TikTok, LinkedIn, attention studies) and a comparison of each brand's most-viewed and least-viewed designed Reels on the same account. In that comparison, the message on screen at frame 0 and a native vertical layout separated the winners; constant motion alone did not.

1. **Frame 0 is a finished poster with the message on it**: the headline, the question or the number over the subject, readable as a still. Winners did this 16 of 20 times, the weakest 9 of 17. Something starts moving within 0.3 s; the point is stated by 3 s.
2. **Native size, never letterboxed or squeezed.** Each platform size is its own layout: a 9:16 film and a 4:5 film are separate pages laid out for their frame. All 20 winners were native vertical; 4 of the 17 weakest were letterboxed.
3. **Something new starts every 1 to 2 s while a scene builds, and every 2 to 3 s during a hold**: a cut, an entrance, a word swapping in, a number ticking, a dot popping on a line, the chart taking its next step. Eyes go to motion that starts, not to motion that has been running. The content keeps building to the end (the line extends, the list fills, the counter climbs); a scene that is built at 1.5 s and then waits is the slide feeling.
4. **One ambient layer runs start to end** under everything, as a `layers` track: footage under the type, a slow drift on the photo, a ticker, a turning ring, or a progress rail. It stops any frame from looking frozen. It does not replace point 3.
5. **A progress rail only for a sequence** (a list, an agenda, a countdown, a match timeline): one segment per item, filling as each item lands, so it fills fast at the start.
6. **Hook copy is a question or a number** ("Guess how much these combos cost?", "50,000 businesses"), never a category label.
7. **6 to 15 s for one message**, 30 s at most.
8. **Sound off works**: every fact the viewer needs is on screen. Music still goes under it when the brand has a track.
9. **A small logo in a corner the whole time**, in the ambient track, instead of a big logo card at the start.
10. **The last frame leads back to the first**, so the replay looks intended: end on the post, the same layout frame 0 opened on, or a calm hold of it.

## Formats by post type

Sizes: 9:16 (1080x1920) for Reels, TikTok and Stories, keeping text between 168 px and 1530 px from the top and the hero and numbers above 1330 px; 4:5 (1080x1350) for the Instagram and LinkedIn feed; 1:1 or 16:9 for X and LinkedIn product videos.

### Event, class or workshop: word, then the card

| Scene | Length | What happens |
|---|---|---|
| The word | 2.5 to 3 s | The venue or activity photo full bleed with a slow push. The one word that sells it (`SATURDAY`, `WORKSHOP`, the date `14.11`) is on screen by 0.4 s, huge, and leaves by zooming through itself. |
| The card | 8 to 10 s | The place-and-date card from the image format. The event name reveals by word by 0.6 s, the meta line follows 0.4 s later, the price or seats chip pops last. A circle or underline draws around the date (SVG `drawIn`, 1.2 s). Then it holds; only the photo keeps pushing. |

- Cut: `zoomThrough` into the card, targeting the word.
- Variant for a series: a countdown (`03 DAYS`) as the word, its digits rolling down from the day before.
- Fields: `event_name`, `meta_line`, `price`, `photo`, `hook_word`.

### Launch or feature update: the UI gets used, then the card

| Scene | Length | What happens |
|---|---|---|
| The component | 6 to 9 s | The one component that changed (a status row, a toggle, a card), drawn as SVG and enlarged 3 to 4 times on a flat dark or brand ground, already there at frame 0. It fills 60 to 70% of the frame width and its labels read at phone size (at least 3% of the frame height); a whole window at normal size is too small. A fingertip or cursor glides in at 1 s, presses or hovers at 2 s, the new state lands (a tooltip scales in, a status swaps, a counter ticks) and holds 2 s. |
| The card | 4 to 5 s | The changelog card: the version chip and a 1 to 3 word headline at lower left, the component settled on the right in its final state. |

- Cut: `grow` from the component into the card, or `match` the component so it travels into place.
- The headline lives on the card, not over the demo. The post text carries the details.
- No headline in scene 1 and nothing else moving there: the cursor and the change are the whole scene.
- Fields: `headline`, `chip`, the component's labels and values, `visual` when the user has a real screenshot.

### Match day, final score or lineup: slam, score with a timeline, the photo card

The worked example for this format, with every layer and time: [`examples/match-day-film.md`](examples/match-day-film.md).

| Scene | Length | What happens |
|---|---|---|
| The slam | 3 to 3.5 s | `FULL TIME` (or `GOAL`, `MATCHDAY`) fills the frame width at frame 0, settling from 1.2x with a blur that clears in 0.4 s, over the same words repeated in faint drifting rows on a gradient ground. At 0.7 s a band wipes across with the result line (`Harbour City win`) revealing by word; the competition line follows at 1.6 s. Leaves by zooming through the word. |
| The score | 5 to 5.5 s | Stadium footage, graded to the club colour, under a pitch that draws itself line by line. The two digits, 700 px tall, count up and settle by 1.7 s, the winner's in the accent with a bar wiping under it; the team names reveal under them. From 2.3 s a match timeline runs from KO to FT and each goal pops as the line passes its minute (home goals above in the accent, away goals below). |
| The photo card | 6 to 6.5 s | The edge-rail post: the player photo raised so the player sits above the type, a navy grade and a scrim; the rail word wipes up the edge, the crest draws in, the score block lands row by row, a glow grows behind the winning digit. Player of the match pops at 2.4 s, the venue line at 3.6 s, a light sweep at 4.6 s, the crest's star turns on a loop through the hold. |

- Cuts: `zoomThrough` out of the slam, then `push` up into the card.
- A progress bar runs the whole film as a `layers` track, changing colour with the ground.
- Lineup: one long scene. The title by 0.5 s, the eleven rows land 0.1 s apart (numbers left, names right), the bench line last, then a hold of 8 to 10 s while one small thing moves (a light sweep, a photo chip swapping in a row). A slanted re-flow of the rows into a staggered poster layout at about 2 s is the strong version.
- Fields: `result_line`, `matchday`, `home_team`, `away_team`, `home_score`, `away_score`, `photo`, `stadium_video`, `rail_word`, `potm`, `scorers`, `venue`, and per goal `gN_min` and `gN_name`; for the lineup, one field per row.

### Stat, milestone or chart: number, chart, count

| Scene | Length | What happens |
|---|---|---|
| The lockup | 3 to 3.5 s | Three stacked lines: `we just hit` / the number with its unit, huge, in the accent / `on the platform`. On screen by 0.2 s, lines 0.2 s apart. |
| The chart | 9 to 11 s | Kicker, headline that states the conclusion, axes and source already there at frame 0. The line draws left to right over 2.5 to 3 s; callout cards pop at 2 or 3 milestones as the line passes them (0.35 s each). The insight lands after the line settles. |
| The count | 3 to 4 s | `AS OF TODAY` and the exact number counting up to the round figure over 1.5 to 2 s, then a one-line closer. |

- Cuts: `zoomThrough` the number into the chart, then a `wipe`; a thin progress rail along the bottom (a `layers` track) fills over the whole film.
- The plot fills 70% or more of the frame. The lockup and the count scenes fill the frame too: the number at 25 to 30% of the frame width per digit group, a drawn line or the chart's ghost behind it, never a number alone at the top of an empty ground.
- A count layer is as wide as its final, formatted number (`50,000` with the comma), or the number wraps while it counts.
- The drawing follows the user's data; numbers on text and count layers change per render.
- Fields: `number`, `unit`, `headline`, `source`, `closer`, the callout labels.

### Speaker, webinar or podcast guest: introduce, reveal, date

| Scene | Length | What happens |
|---|---|---|
| The introduction | 2.5 s | A boxed label (`INTRODUCING`, `THIS MONTH'S WEBINAR`) with the series lockup, on screen by 0.3 s. |
| The speaker | 7 to 8 s | The split speaker card: the black and white portrait rises from the bottom edge (1 s, power3 out), the name lands between two rules that draw outwards, the talk title reveals by word, the role last. |
| The date | 3 to 3.5 s | The date line and the call to action (`Save your seat`), with the portrait still in place. |

- Cuts: `push` from the introduction; `match` the portrait so it stays while the date scene changes around it.
- One template serves every guest: same layout, new name, photo and title.
- Fields: `speaker_photo`, `speaker_name`, `speaker_role`, `talk_title`, `date_line`, `cta`.

### Real estate: status word, rooms, proof numbers, contact

| Scene | Length | What happens |
|---|---|---|
| The status | 3.5 to 4 s | The exterior photo with a slow push. `Just listed` or `Sold` writes itself on (a script word as SVG paths with `drawIn`, 1.2 s), then the price or `IN 7 DAYS` under it. |
| Rooms, 2 or 3 | 3.5 s each | One photo per scene, alternating pan direction, the room name and one feature line. |
| The numbers | 5 s | Beds, baths and area (or, for sold, days on market and enquiries) as drawn icons that stroke in 0.4 s apart, each number counting up as its icon finishes. |
| The contact | 3 s | Agent photo, name, phone, agency mark. Holds. |

- Cuts: `push` left through the rooms, then one `grow` from a small agent chip into the contact card.
- The price and address stay on screen through the rooms as a slim rail (a `layers` track); a listing video without them fails the viewer who joins late.
- Fields: `status`, `price`, `address`, every `photo`, the feature lines, `beds`, `baths`, `area`, `agent_name`, `agent_phone`, `agent_photo`.

### Weekly menu, specials or timetable: one item per beat

| Scene | Length | What happens |
|---|---|---|
| The week | 2.5 s | `Week 44` and the date range over a hero dish, on screen by 0.4 s. |
| The fill | 8 to 12 s | One day per beat, 0.7 to 1 s apart: a photo tile drops into a grid with the day name set on the photo, or a row lands in the row table with its price popping in the accent. When the last one lands, the whole week holds 4 s or more. |

- Cut: `wipe` down into the fill.
- The last frame is the whole week: it is the cover and the screenshot people save.
- For a timetable with many rows, rows land 0.1 s apart and the hold is long (one long scene), as in the lineup.
- Fields: `week_label`, and per day `item`, `price` and `photo`.

### Customer quote: the result, the words, the person

| Scene | Length | What happens |
|---|---|---|
| The result | 3 s | The outcome as a number counting up (`3x more bookings`), or the strongest phrase of the quote set huge. |
| The quote | 6 to 8 s | The quote reveals by word. A marker stroke draws under the key phrase (SVG `drawIn`, 0.8 s) after the line finishes. Stars draw in one by one when there are stars. |
| The person | 3 s | Photo, name, role and company; the brand mark lands last. |

- Cuts: `blurSwap` (same stage, new state) or `slide`, one family.
- Variant: review cards popping out of a phone mockup 1.2 s apart, the last one large enough to read.
- Fields: `result`, `quote`, `name`, `role`, `photo`. Only real quotes; a sample quote is labelled as a sample.

### Carousel as a video: one scene per slide

Paired with `orshot-carousel`, which writes the hook, the slides and the CTA slide.

| Scene | Length | What happens |
|---|---|---|
| The hook | 3 s | The carousel's slide 1, re-laid for 9:16: the hook (a question or a number) on screen at frame 0 over a graded photo or footage. |
| Each slide | 3 to 5 s, from the pacing rule | The slide's headline reveals by word, its picture pushes in, its one number counts or its icon draws. |
| The CTA | 3 s | The last slide: the action and the handle, holding. |

- A segmented progress rail at the top: one segment per slide, each filling while its slide plays (a `layers` track, one clip per segment anchored to its scene).
- One cut family for every slide (`push` or `slide` in reading direction); no continuity cut except into the CTA.
- Fields: the carousel template's own fields, prefixed per scene (`page3@title`).

### Video ad: product and offer at frame 0, proof, end card

Paired with `orshot-ad-creative`, which sets the offer, the hook, the product photo and the CTA. Under 6 s with one scene, the ad skill's animated banner is enough.

| Scene | Length | What happens |
|---|---|---|
| The hook | 2.5 to 3 s | The product and the offer at frame 0: the product photo or clip full bleed, the offer (`40% off`, the price) huge, the price counting or a badge popping by 0.5 s. |
| The proof | 4 to 6 s | One reason to believe, acted out: the product in use (footage), a before and after, a rating with stars drawing in, or one benefit per beat with a drawn icon. |
| The end card | 3 s | The product, the price, the CTA button that gets pressed (`press`) and the logo. Holds. |

- 6 to 15 s. Sound off works: the offer and the CTA are on screen, not only in a voiceover.
- Each ad size is its own native layout (9:16 for Stories and Reels, 4:5 and 1:1 for the feed), rendered with `size`.
- Prices, discounts and claims only from the user or the feed.
- Fields: `offer`, `price`, `product_photo`, `product_video`, `benefit_N`, `cta`.

## Anti-patterns seen on weaker videos

- An empty colour or black for a second before anything appears.
- A flat colour ground with type on it and nothing behind: no footage, no photo, no gradient, no pattern.
- A scene that is built by 1.5 s and then waits with nothing new and nothing looping.
- Every layer sliding in together, then nothing happening.
- A static infographic or speaker grid exported as video, or 30 to 90 words on a page that cuts after 5 s.
- One caption on the first shot and then footage with no price, date or contact on screen.
- A 16:9 design letterboxed inside 9:16.
- Crossfades with a white flash between content scenes: it reads as a slideshow.
- Abstract glow and 3D with no number, product or photo of the real thing.
- Tiny type for atmosphere: unreadable on a phone.
