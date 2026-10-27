# Post formats brands actually run

Built from 93 single-image posts that brands and clubs published in 2026 on LinkedIn and Pinterest (33), Instagram (20), posts.design (20) and saved design references on X (20): product teams, clubs, shops, studios, cafes, brokerages and media accounts. Each format below is one a brand posts again and again with new content, which is exactly what a template is for. Pick the format by post type, build its fixed frame once, and make only its fields dynamic.

Field names, sizes and render options live in the docs and in `orshot://template-design-spec`. This file only says what to build.

## What the strong posts have in common

1. **One idea, few words.** 2 to 12 words on the canvas for announcements, events and statements, under 25 on any photo post. The caption carries the rest. Only list posts (menus, timetables, results) and charts go higher, and they earn it with identical rows on one grid.
2. **One hero, much bigger than everything else.** The hero (a number, a status word, a score, a 1 to 3 word headline, a face) is 3 to 10 times the size of the next text. Three or four type sizes in total. A post where every element is 3 to 6% of the canvas reads as a template pack.
3. **Meta set small, on one line.** Date, time, place, role, version and source go in one row with separators, in a mono face or tracked caps at 2 to 3% of the width: `SAT 14 NOV · 8AM TO 1PM · MILL LANE`. Never three stacked labels.
4. **Text in a corner zone, left aligned.** Bottom left or top left, ragged right. Centre only a single number, a single word or a 1 to 2 line statement.
5. **The picture bleeds off an edge.** Photos, cut-outs, renders, charts and giant type run off at least one edge. Nothing floats in the middle with equal padding around it.
6. **Text sits on the empty part of the picture.** Sky, wall, floor or backdrop, with the subject on the opposite side. A scrim or box is the fallback for a photo you do not control, not the plan.
7. **One accent, one job.** Ground, one ink, and one accent used on one thing: the key word, the price, the winning number, a date chip. Two type families at most: a display face plus a mono or caps label face.
8. **A fixed frame and a series device.** The logo spot, label position, footer and margins never move between posts, and a series marker says this is a recurring post: `#12`, `V.07`, `Issue 31`, `Week 44`, `Matchday 9`, `Hot take #3`, a page counter `01 / 04`. That frame is what makes a brand's grid look designed.
9. **One treatment that makes any photo fit.** Per-render photos differ in colour and quality, so the template grades them the same way every time: black and white, duotone in the brand colours, a cut-out on a plain ground, or a device frame. This is how one template survives a hundred different images.
10. **Margins of 5 to 8% of the width** for text and logos. Pictures may break the margin; text never does.

## Formats by post type

Each entry: the skeleton (zones on a 1080x1350 portrait canvas unless noted), what makes it work, and the fields that change per post.

### Event, class, meetup or workshop: place-and-date card
- **Skeleton:** full-bleed photo of the place or the activity (the venue, the studio, a landmark of the city). Event name in the photo's empty area, 1 to 3 words, large. One meta line under it: date · time · place. Optional co-host or sponsor logo row at the bottom, small, ruled.
- **Works because:** the photo says where, the line says when, nothing else competes.
- **Fields:** `event_name`, `meta_line` (or `date`, `time`, `place` joined in one line), `photo`, optional `price`.
- **When the photos have no calm area** (close-ups of hands, food, a crowd): the photo fills the top 55 to 60% and the name, meta line and price sit on a solid band below it in the ground color, with one chip (seats left, sold out) pinned across the seam.
- **Variant for a series with a changing number:** a fixed event frame with one large variable, a countdown (`03 days`), the session number or the date set huge and rotated up one edge.

### Speaker, webinar, podcast guest or new hire: split speaker card
- **Skeleton:** title zone on one half (format chip such as `WEBINAR`, the talk title in 2 to 3 lines, name and role, date line in mono); a large black and white portrait on the other half, bleeding off the bottom or side edge. A cut-out (transparent background) with the face at 35 to 50% of the canvas width is strongest; with an ordinary headshot, fill the half with the photo and ask the user for tighter crops or cut-outs. Square for LinkedIn and X together, 16:9 for X alone; 4:5 stacks the title above the portrait.
- **Works because:** black and white makes any headshot match the brand; the layout holds whether the title runs 2 or 3 lines.
- **Fields:** `title`, `speaker_name`, `speaker_role`, `speaker_photo`, `date_line`, `format`.

### Launch or feature update: changelog card
- **Skeleton:** a dark or brand-coloured ground; a small chip with platform and version (`MAC · v2.8`) above a 1 to 3 word headline at lower left; the hero render, UI crop or product photo owns the right 50 to 60% and bleeds off the edge. 16:9 or 2:1 for X, 4:5 for Instagram and LinkedIn (chip and headline at the bottom, render above).
- **Works because:** one feature, named in a few words, shown big. The chip makes it a weekly series.
- **Fields:** `headline`, `chip`, `visual` (a screenshot crop or render), optional `version`.
- **UI in a post:** crop real UI to one panel or one component at a size that reads on a phone, and float it on a calm ground (a soft photo, grain gradient or flat colour). A whole dashboard shrunk to fit reads as nothing.

### Milestone, funding, growth or report stat: one big number
- **Skeleton:** logo top left; one number at 20 to 25% of the canvas height (or 40 to 60% of the width); one label line under it (`Revenue growth in Q3`, `Series B`); optional ruled grid of investor or partner logos on one side; source line at the bottom.
- **Works because:** the number is the post.
- **Fields:** `number` (a count-up value in video), `label`, optional `source`, `logo_grid`.
- **Never** over a busy photo: the number needs a flat or softly graded ground.

### Chart or study finding: annotated chart
- **Skeleton:** headline states the conclusion, not the topic (`Win rates rise 50% when the topic is captured`); one legend line; the chart drawn as SVG in the brand colours with labels inside or beside the marks; bars or lines may bleed off the bottom; source line and logo in a footer.
- **Works because:** readable at feed size: 3 to 6 bars or 2 to 3 lines, the winning value in the accent, everything else in one neutral. Up to about 40 words, counting labels and the source.
- **Fields:** `headline`, the values and labels (one per bar or point), `source`, and each bar's length, set at render time on the bar layer (`bar_a.width`). For a chart whose shape changes completely, patch the drawing instead.

### Hiring: role card or status word
- **Skeleton A (role card):** the role title is the headline; small meta line (location · type · team); the company logo; optional list of 2 to 4 open roles styled as UI rows; one CTA line.
- **Skeleton B (status word):** `WE'RE HIRING` set huge in the empty part of a photo of the actual place (shop front, office, kitchen), one line for the role, small logo.
- **Fields:** `role`, `meta_line`, `photo` or the roles list, `cta`.

### Quote, testimonial or opinion: three shapes
- **Big statement:** one 3 to 15 word line (the strongest part of a longer quote) in a large serif or extended caps on a flat or textured ground, attribution small under it, one accent mark (the key phrase coloured, circled or struck through).
- **Review card:** small portrait, stars drawn as SVG, the quote with its strongest sentence in the display face, name and role.
- **Borrowed UI:** the quote set as a post or message card (avatar, name, handle) on a plain ground.
- **Fields:** `quote`, `name`, `role`, `photo`. Quotes come from the brand's own people or real customers. Never a famous founder's face on a generic quote.

### Real estate: status word over the property, or fact sheet
- **Status word:** `JUST LISTED`, `JUST SOLD`, `OPEN HOUSE` set huge in the sky of the exterior photo (the house in the lower 60%), one address line, the agent's or brokerage's logo small.
- **Fact sheet:** the hero photo in the top 60%; a fact band below with the price as the biggest text and beds · baths · area on one row (drawn icons or plain labels); one contact line.
- **Fields:** `status`, `address`, `price`, `beds`, `baths`, `area`, `photo`, `agent_name`.
- Avoid the realtor template-pack look: script plus serif plus caps on one post, a grid of 4 small photos, a three-line contact footer.

### Weekly menu, class timetable or opening hours: row table
- **Skeleton:** title and date range at the top (`Week 44 · 27 Oct to 2 Nov`); 5 to 7 identical rows (day, item or time, price), on one grid, aligned to one indent; footer with the place. Typography only, or one photo strip at the top.
- **Works because:** it is the one post people screenshot. Identical rows let 40 to 70 words read.
- **Fields:** the item and price of each row (`tue_item`, `tue_price`...), `week_label`. Day names are static unless the days change.

### Deal, new arrival or price drop: product on a plain ground
- **Skeleton:** the product cut out or on a clean background, 45 to 60% of the canvas; product name; price in the display face with the old price struck through; one badge for the offer (`-30%`, `Back in stock`); small dated header.
- **Fields:** `product_photo`, `product_name`, `price`, `old_price`, `badge`, `date_label`.
- Product grids (4 to 6 identical cards under a dated title) are the variant for daily deals.

### Match day, score or lineup: edge rail over the photo
- **Skeleton:** full-bleed photo of the player or team; one word rotated up the left or right edge as a tall rail (`MATCHDAY`, `FULL TIME`, `STARTING XI`), 12 to 18% of the width; crests, score or kick-off time in a corner block; competition and venue as a small meta line.
- **Score variant:** the two numbers huge, stacked or side by side at about 12% of the width, on the rail or over the empty area.
- **Fields:** `photo`, `rail_word`, `home_team`, `away_team`, `home_score`, `away_score`, `meta_line`. Name both teams, so away games work.
- The same frame serves every single-message moment of a match day: preview, half time, full time, player of the match. A lineup needs room for 11 names, so it is a second page in the same template with the same rail and photo treatment.

### News, a take or a tip series: headline on photo, or object card
- **Headline on photo:** an editorial photo with the subject in the top half; a 3 to 5 line headline at the bottom left; small kicker and logo top left.
- **Object card:** a paper object (a receipt, a notebook page, a ticket, a sticky note) drawn as SVG, tilted a few degrees on a photo or a colour ground, holding a numbered headline (`Hot take #4`).
- **Fields:** `headline`, `kicker`, `photo`, `number`.

## Platform notes

- **Instagram:** 4:5 is the default feed size. The profile grid now crops tiles to 3:4, so keep the logo, rail and key text inside the middle 94% of the height. Stories and Reels covers: keep the top 12% and bottom 15% for the logo and meta only.
- **LinkedIn:** designed cards are mostly 4:5, then 1:1. 16:9 is for product screenshots and event series. The feed shows images about 555 px wide, so text under about 2.5% of the canvas width is unreadable there. A source line on every stat.
- **X:** 16:9 for announcements and changelogs, 1:1 for events and hiring. Keep text in the left 60% of a 16:9 card.
- One template can serve several sizes with `extraSizes`; check each size's thumbnail, since stacked 4:5 and side-by-side 16:9 are different layouts.

## Anti-patterns seen on weaker posts

- A centred headline on a gradient with nothing else, or a logo alone on a soft gradient.
- The everything-flyer: 8 or more type sizes, starbursts, script plus serif plus outline type, 100 words, a footer stuffed with phone, handle and slogan.
- Every element in its own box at 3 to 6% of the canvas, so nothing reads at thumbnail size.
- A big number or headline over a busy, dark photo with a drop shadow.
- A dense chart with 10 or more categories, or a full dashboard at thumbnail scale.
- A famous person's face on a generic quote; a meme cut-out on a "We're hiring" post for a brand without that voice.
- Glowing purple gradients, podium spotlights and fake 3D UI: the generic AI-launch look.
