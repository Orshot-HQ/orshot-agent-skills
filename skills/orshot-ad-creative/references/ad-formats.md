# Ad formats advertisers actually run

Built from static image ads that were live in October 2026, studied one by one:

- **Meta Ad Library, 40 ads:** 20 from 16 direct-to-consumer brands (food, supplements, beauty, apparel, home, pets, tech; 23 brands scanned) and 20 from SaaS, B2B and local service advertisers, picked from about 230 ad cards scanned (roofing, HVAC, med spa, dental, hiring, movers, real estate, B2B lead magnets).
- **LinkedIn Ad Library, 11 ads:** picked from the 24 newest ads of each of 10 B2B software advertisers (240 cards).
- **Google Ads Transparency Center, 9 ads:** picked from about 4,000 creatives across 41 advertiser and domain searches, with first-shown dates for 172 image ads. The oldest designed banner had been shown for 1,515 days.

Most had run 30 days or more, or in several versions, which is the closest public signal of a winner. Each format below is one an advertiser runs again and again with a new hook, offer, product or price, which is exactly what a template is for.

Field names, sizes and render options live in the docs and in `orshot://template-design-spec`. This file only says what to build. The common field ids (`headline`, `price`, `old_price`, `offer`, `product_image`, `photo`, `phone` and the rest) are set once in SKILL.md; a format's field list shows what it adds.

## What the winning ads have in common

1. **Winners are systems, not single ads.** The same offer or quote runs in 3 to 6 layouts: one brand's customer quote in 3 layouts, a free dog bed in 4, a 25% off in 4, one copy angle in 6 illustrated variants. B2B does the same: one lead-magnet frame across 5 titles. Build 2 to 4 templates for one campaign with the same field names, and rotate them.
2. **One idea per image.** The hook is 2 to 6 words on most strong ads ("Half the sugar. All the fizz.", "$100 off", "Coldest. Sheets. Yet."). Long text appears only when length is the point: a review, a text message, an email screenshot. A local offer ad can carry 50 to 100 words when the offer box is 3 to 5 times larger than everything else.
3. **The offer or the asset is the hook.** "3 months of coffee for $45", "$150 furnace + AC tune-up", "500 free email templates", "Brow lamination only $79". No clever headline above the offer.
4. **The product is big.** 40 to 75% of the frame, usually a clean cut-out, often cropped by the canvas edge so it reads large on a phone. A small product floating in the middle is the generic look.
5. **Specific numbers beat adjectives.** "$2.65 per meal", "2g vs 39g of sugar", "less than $1 a day", "a million orders shipped".
6. **The offer sits on the product, not in a footer.** The price under the kicker, a sticker overlapping the pack, the last proof pill is the price. Price anchors and qualifiers sit right under the price ("Reg. $399", "for up to 24 months").
7. **Colour from the product.** The ground is one flat brand or product colour (olive-oil lime, root-beer brown, a brand orange) or one photo; 2 to 3 colours in all, one accent used only for the offer or proof element. Never a gradient behind the hook.
8. **Show the deliverable or the outcome, not a generic person**: the report cover, the exact app screen, their own roof or truck, the broken unit.
9. **CTA on the image only where it helps.** Rare on DTC ads (the ad unit's button does it). Common on SaaS lead magnets and app ads: a pill or button under the hook. Local ads put the phone number or offer on the image instead.
10. **Native formats carry no brand styling.** An iMessage thread, an inbox, a notes page: system font, no logo, the product named only in the text. These are some of the longest-running statics in the set.
11. **Type: 2 to 4 sizes.** Hook 7 to 16% of the canvas width per line (DTC), 7 to 18% (SaaS); a price numeral 20 to 65% of the width. One busy ad with 5 or more sizes survived only on its photos.

## Sizes

- **Feed:** 1:1 (1080x1080) is the default for designed statics and catalog frames; 4:5 (1080x1350) for portrait-led and offer ads. Both fill edge to edge, the product often cropped at the side or bottom.
- **Stories and Reels:** almost every brand ships a native 9:16 (1080x1920) sibling of each static. Its content sits in the middle 65%: the top 13 to 20% and the bottom 20% stay clear of text (the placement's UI). Story versions move the CTA up under the hook.
- **LinkedIn:** 1:1 is the default static (most advertisers ran 17 to 24 of their 24 newest ads square). 4:5 for dense cards: a comparison, a webinar, a report page. 9:16 shows up only as a twin of the square. 1.91:1 statics were rare (2 of 240 cards); that size now carries mostly video posters.
- **Google display:** see the banners section below. Designed banners ran at 300x250, 300x600, 728x90, 468x60 and 970x250. None of about 4,000 creatives was 160x600 or 320x50; Google fills those slots from responsive display assets.
- Design the main size, then re-lay each other size with Smart Resize and look at it; a 9:16 needs its empty bands built in.

## Ecommerce and DTC

### Offer as the headline: price drop, percent off, gift with purchase

The most common format among the DTC brands scanned (about 1 in 4 static ads).

- Skeleton (4:5 or 9:16): kicker in small caps ("3 months of coffee for:"), then the old price struck and faded beside the new price at about twice its weight, then the product or the open box of the bundle filling the middle 45%, a round sticker overlapping it ("+ free mug!") with a hand-drawn arrow, an urgency line last ("Limited time only").
- Variants: a giant dollar number in a display serif with "off" tucked small at its corner and the product orbiting the numerals (`$100 off`); a seasonal band (a knit pattern) above a serif headline and a product lineup where each item carries a label ("Free").
- Fields: `kicker`, `price`, `old_price`, `offer`, `product_image`, `sticker`, `urgency`.

### Claim and an oversized product

Every brand runs this one.

- Skeleton: a 2 to 4 word claim in the top 30% (heavy grotesk or wide caps, two lines, often ending in full stops: "Half the sugar. All the fizz."), a retailer line under it ("available at amazon" with the logo), the product cut-out filling 75% of the width and cropped by the bottom edge so the label is the hero. Or three words stacked one per line with the product stacks entering from both edges.
- Fields: `headline`, `subline`, `product_image`, `logo`.

### Proof chips: a quote or a problem, three numbers, the product

- Skeleton: the hook in quotes (a real customer's words, for example "My 3pm snack, sorted", from the user's own reviews) or a problem line, a 2-line sub with the cost ("and spent less than $20 on a week of breakfasts"), the product cropped off one edge, and 3 pill callouts stacked beside it, each a bold number and a small label (`40g protein`, `27 vitamins`, `$2.65 per meal`). The last pill is the price.
- Variant: a 3-column stat row split by thin rules above a lineup of the product range, and a full-width band with a question and a CTA pill.
- Fields: `hook`, `subline`, `stat_1` to `stat_3` with labels, `product_image`.

### Feature callouts with leader lines

- Skeleton: a dark pill tag ("Machine-washable linen"), a serif headline ("Finally, linen."), a 3-line sub, then 3 feature labels in letterspaced small caps on the left, each with a thin rule running into the product and ending in a dot; the product cut-out bleeds off the right edge. Or two leader lines to italic ingredient labels on a product on a seamless sweep, a price-per-day headline and a CTA pill.
- Fields: `tag`, `headline`, `subline`, `feature_1` to `feature_3`, `product_image`.

### Checklist beside the product in use

- Skeleton: a 2-line headline (huge first line "2-pack on sale", smaller second line), a hand holding the product as the hero on the left half, a round sticker on it ("Back to school"), the product family as cut-outs on the right with a 4 to 5 line spec checklist under them, each line with a check.
- Fields: `headline`, `subline`, `sticker`, `check_1` to `check_5`, `product_image`.

### Us vs them table

- Skeleton: a one-line title "[BRAND] vs TOP SODAS*", the two products side by side (the brand's own and a plain generic one labelled with the category), then a 4-row table: the brand's value left, a label chip in the centre, the other value right, thin rules between rows. A footnote line.
- Fields: `title`, `row_N_label`, `row_N_us`, `row_N_them`, `product_image`.

### Before and after

- Skeleton: two equal photo panels split by a thin rule, BEFORE and AFTER tags in the top corners and again as words at the bottom of each panel with a 2-line caption; one proof bar under them ("1 million shirts sold"). Keep it to the photos, the two words and the proof: the busiest example in the set stacked 5 more elements and survived only on its photos.
- Fields: `before_photo`, `after_photo`, `before_caption`, `after_caption`, `proof`.

### Review card and press quote

- Review: on the brand colour, the customer's photo as a tilted polaroid with a handwritten caption (name and age), overlapping the product pack tilted the other way, 5 stars, the review in 4 to 5 lines centred.
- Press or celebrity: a rectangular photo of the person, a starburst sticker over its corner ("As featured on [the show]"), the quote in a handwritten face, the attribution, the product bleeding off the edge.
- Quotes come from real customers or press with permission. A sample quote shown to explain the layout is labelled as a sample.
- Fields: `photo`, `caption`, `stars`, `quote`, `name`, `product_image`.

### Native screenshot: text message, inbox, notes, story stickers

- Text message: the whole canvas is an iOS Messages thread on white: a blue sent bubble as the hook ("Okay, you will not believe what my sister just sent me."), two short grey replies, a tall blue bubble with the story, "Delivered", a last grey reply cut off by the edge. System font, one size, no logo.
- Inbox: a phone status bar and mail toolbar, the subject large ("FREE CAT TREE"), the sender row, two lines of body, the product photo as the email image, a sign-off.
- Story stickers: a recipe or product photo with Instagram-style text stickers on it.
- Build the UI as shapes and system-font text (Inter or SF-like), so the bubbles and subject are fields. Fields: `bubble_1` to `bubble_N`, or `subject`, `body`, `product_image`.

### Illustrated listicle or meme

- Skeleton: a 2-line heavy rounded headline in the brand colour with an emoji at both ends ("Signs your dog is bored"), a 3x2 grid of spot illustrations of the same character, each with a 2-line caption; no product, no logo. The meme version: a quote-style headline, a hand-drawn scene, a punchline caption.
- Fields: `headline`, `item_1` to `item_6` captions; the drawings are fixed in the template.

### Bundle or product grid

- Skeleton: a big offer line ("Pick 6. Save more."), the products as a colour grid or the trial box with its contents laid out, each with a small label.
- Fields: `headline`, `item_N_image`, `item_N_label`, `price`.

### Catalog frame on a feed product (Advantage+ catalog)

One render per product in the feed, 1:1.

- Frame A: a thin top band in the brand colour with the logo left and a message centred ("Weekend ready"), the product photo whole on light grey, a white bottom bar with the product name left and the price right.
- Frame B: the logo centred on off-white, the product photo inset with an even margin, a price pill overlapping its top-left corner, the product name centred under it.
- Several large retailers run catalog ads with no frame at all, a plain packshot, and let the feed and the ad copy carry the price. A frame is a choice: use it when the price, a sale badge or the brand needs to be on the image.
- Fields: use the Shopify app's product field names from its docs (image, title, price and compare-at price, plus its sale-only layer rule) so the app fills them; add `message` for a campaign line. Other feeds map their columns to the same ids (see the catalog section in SKILL.md).

## SaaS, B2B and apps

Big consumer SaaS runs few statics; the ones that do are mostly lead magnets. Each frame is reused across many titles.

### Lead magnet: free guide, template, report or prompts

- Skeleton (1:1 and a 9:16 sibling): an eyebrow "FREE OFFER" or "FREE EXCEL TEMPLATE" in a dashed box, the asset's title as the hook (serif or grotesk, 2 to 3 lines: "Quarterly content planner."), a 1-line benefit, a picture of the asset (an illustration of a calendar, an isometric spreadsheet, a photo of someone using it) taking half the frame, a Download button and the logo. One accent colour used 2 to 4 times (the full stop, the logo, the button).
- Keep dates out of evergreen titles, or make the year a field: a "for 2025" guide still running in October 2026 reads stale.
- Fields: `eyebrow`, `title`, `benefit`, `asset_image`, `cta`.

### UI in a device or UI cards

- Skeleton: the hook and a CTA pill at the top, then the exact app screen in a phone, or 2 to 3 floating UI cards cropped off the right edge, on a flat brand colour. A single toggle or button enlarged as the whole visual ("Sync in one click", with the cursor on the toggle and the partner logo).
- Fields: `headline`, `cta`, `screen_image`.

### Screenshot and a question hook

- Skeleton: "You know your hourly rate. Do you know your profit per job?" in heavy italic caps over the real report screen, tilted, with the one number circled; a band with the payoff line and the logo.
- Fields: `hook`, `screen_image`, `payoff`.

### Integration or logo equation

- Skeleton: on a bright flat colour, the headline (2 lines, bold), the product's mark + "+" + 4 to 5 partner logos in a row, a bar CTA ("Free 3 month trial").
- Fields: `headline`, `subline`, `partner_logos`, `cta`.

### Review badge grid

- Skeleton: the product name and category in a top bar, then 4 review-site logos (G2, Capterra, TrustRadius, Spiceworks) with star rows in a 2x2 grid on a dark ground. A 1.91:1 link ad.
- Fields: `title`, ratings per site.

### Webinar ticket

- Skeleton: a "WEBINAR" eyebrow, the title in a serif over 3 to 4 lines on the left, the host as a cut-out on the right, a strip with date, time and host name with small icons, a full-width bar "Reserve your spot".
- Fields: `title`, `subline`, `host_photo`, `host_name`, `date_line`, `cta`.

### Text message pain point

- Skeleton: an iOS Messages screen with one contact ("Client") and one painful bubble ("Where. Is. The. Invoice."). No brand. The ad copy carries the product.
- Fields: `contact`, `bubble`.

## Local services and recruiting

Most local advertisers run plain photos with no text: in the scan, about 85 to 90% of local service image ads, and none of about 60 real estate and restaurant ads, had anything on the photo. The price, the offer and "free estimate" live only in the ad text, so a viewer who does not read the text never sees them. That is the gap a template fills: the offer on the business's own photo, in the same frame every week.

### Offer box on the business's own photo

- Skeleton (1:1): a top bar with the logo and the headline ("Pay for your new roof over time"), the job-site photo (their own roof, their own truck) as the middle, a round "Special offer!" sticker on it, a big offer box at the bottom ("0% financing" with "for up to 24 months*" under it), one line of legal at a readable size.
- Fields: `headline`, `photo`, `offer` (the sticker), `price`, `old_price`, `offer_terms`, `phone`, `legal`, `logo`. A financing or rebate month hides `old_price` with its opacity.

### Big price, type only

- Skeleton (4:5): on one flat brand colour, a giant outlined price numeral filling 60% of the width ("$150"), the service name under it ("Furnace and AC tune-up"), one reassurance line ("One visit, two seasons, no surprises."). Give the lower half something to hold (the service icon, a photo strip or the logo bar): an empty half canvas looked unfinished next to the strong ads.
- Fields: `price`, `service`, `line`.

### Price special on a portrait (med spa, salon, dental)

- Skeleton: the treatment name in spaced caps at the top ("NEW CLIENT SPECIAL", "BROW LAMINATION"), a portrait filling the right two thirds, the price glowing on the left ("Only $79", "Reg. $120" under it), a small urgency line ("Limited time only!").
- A dense coupon flyer (stacked offer boxes, an icon row, an award badge, the address and phone footer) works for warm local audiences but fails at thumb size; prefer one offer per ad and rotate.
- Fields: `treatment`, `price`, `old_price`, `photo`, `urgency`.

### Consequence photo and a pun hook

- Skeleton: a dramatised failure photo filling the frame (a melting AC unit, a burst pipe), the pun hook in heavy caps across the lower third ("Beat the heatwave"), one CTA pill ("Tune-up now"), the logo badge top centre.
- Fields: `photo`, `hook`, `cta`, `logo`.

### Now hiring

- Skeleton: "NOW HIRING" huge in two lines at the top left, the role ("Delivery drivers"), "Interested? Call at" and the phone number in the accent, the company's own truck or equipment photo filling the rest, a benefits list in small caps at the bottom, the website last. Or a hand-drawn "Help wanted" sign over a landscape with the truck and 4 values.
- Keep the pay and the city in the ad text when one image serves several locations, or make them fields.
- Fields: `role`, `phone`, `photo`, `benefit_1` to `benefit_5`, `website`.

### Example price chips (movers, travel, quotes)

- Skeleton: the hero vehicle, 3 ticket-shaped chips above it each with a route and a price ("Denver > Austin $1,180"), a bar CTA at the bottom ("View your rates >").
- Fields: `route_N`, `price_N`, `photo`, `cta`.

### Real estate and restaurants

The advertisers scanned ran the listing or the dish as a plain photo. When a price, a status or an open-house date belongs on the image, use the social formats file's status word over the property or a slim bar on the photo, and keep the photo at least 75% of the frame.

## LinkedIn and B2B series

Every B2B advertiser in the LinkedIn scan ran one layout again and again: one brand ran all 24 of its newest ads as 5 customer stats in 2 sizes, another 5 hooks in 4 colourways, another 8 hooks on the same person. The template's fields are the hook, the highlighted word or number, the proof object (a logo, a headshot, a cover, a screen) and the colourway. Two rules carry over from the scan:

- **Crop the proof object at the edge.** Report covers, document pages, UI panels, logo tiles and person cut-outs bleed off the bottom or side. A full, centred mock-up looks like stock; a cropped one looks real.
- **One accent, on the thing to read first:** the number, the highlighted words, the CTA. Two to three colours in all; the ground is one brand colour or a two-stop gradient.

### Customer stat card

- Skeleton (1:1, with a 9:16 twin): the customer's logo top left; a giant number at 12 to 15% of the width per line in the accent ("3.4x", "41h saved"); a 3-line sentence saying what it means; a small decorative grid with a few squares in the accent; a footer bar split 40/60, the brand's logo on dark and a CTA block ("Get a demo >").
- A new case study is new data in the same frame. Give each customer its own ground colour if the brand has a palette.
- Fields: `customer_logo`, `stat`, `stat_sentence`, `cta`, `ground`.

### Hook series with highlighted words

- Skeleton (1:1): a rounded card inset 5% on a white margin; the app icon top left; a 3-line hook at about 5.5% of the width with 2 to 3 key words on solid marker boxes; a black pill CTA under it ("Watch on demand"); a column of bold illustration or one person cut-out on the right, bleeding past the card edge.
- A variant drops the boxes and splits the weight instead: a bold first line ("Hire Aria, your night-shift SDR") and a light second line, with the product name in the accent.
- Fields: `hook`, `highlight`, `cta`, `illustration` or `person_photo`, `colourway`.

### Report or guide cover, cropped

- Skeleton (1:1): the logo; an eyebrow naming the source or type in italic ("Analyst report:", "Free checklist"); a 3-line claim or question at 7 to 10% of the width; a smaller CTA line or ghost button ("Read the guide >"); the cover, or 3 real interior pages fanned in a row, cut off by the bottom edge.
- Real pages prove there is substance behind the click. A named third-party source in the eyebrow lends the claim its credibility; use it only when the user has that report.
- Fields: `eyebrow`, `claim`, `cta`, `cover_image` or `page_1` to `page_3`, `ground`.

### Logo wall

- Skeleton (1:1): the brand logo centred at the top; a 2-line headline with the number in the accent ("Trusted by 4,000+ clinics"); 3 rows of white rounded logo tiles that bleed off both side edges.
- Tiles cut by the edge say "there are more", so 9 logos read as thousands.
- Fields: `headline`, `number`, `logo_1` to `logo_12`, `ground`.

### Quote card on a visible grid

- Skeleton (1:1): thin grid lines inset about 5% from each edge; a 6-line quote with a hanging open-quote mark across the top 55%; a square headshot cell bottom left, name in bold and title with company beside it. No logo needed; the post header carries the brand.
- Two colours (a pale ground, a dark ink for text and lines). A long quote works when it is the only thing on the card.
- Fields: `quote`, `photo`, `name`, `title_company`, `colourway`.

### With vs without

- Skeleton (4:5): a serif title and the logo; a 2-line study blurb; two equal columns, the "with" column in the brand tint and the "without" in grey, each with 3 stats (big number, small label, bar); 3 small takeaway tiles at the bottom.
- Dense by design (about 75 words), so it works in a 4:5 feed slot and nowhere smaller.
- Fields: `title`, `blurb`, `left_label`, `right_label`, `stat_N_left`, `stat_N_right`, `takeaway_1` to `takeaway_3`.

### Big offer, type only

- Skeleton (1:1): the logo; a 3-line all-caps offer at about 12% of the width, the last word in the accent ("3 MONTHS FREE"); a 2-line qualifier; a CTA button in a contrasting colour; one legal line. Decorative shapes (confetti, ribbons) fill the free space, never more words.
- Fields: `offer_1` to `offer_3`, `qualifier`, `cta`, `legal`.

### Webinar with a speaker row

- The live version of the webinar ticket above, for 2 to 4 speakers (4:5): co-host logos with a divider; a "LIVE WEBINAR" eyebrow; a 3-line condensed bold title at about 9% of the width; round headshots in a row with name in bold and company under each; date and times in 2 zones; a full-width "Register now" button.
- Fields: `logo_1`, `logo_2`, `title`, `speaker_N_photo`, `speaker_N_name`, `speaker_N_company`, `date`, `times`, `cta`.

## Google display banners

Most image ads that small and mid advertisers run on Google are responsive display ads that Google builds itself from a logo, a headline (30 characters), a description (90 characters), a 1.91:1 and a 1:1 image and a colour, ending in an "Open >" bar. Designed fixed-size banners are a minority, mostly from bigger brands. So for a small advertiser the job is usually the image assets: a 1200x628 and a 1200x1200 photo or product image with little or no text, the subject centred so Google's crops keep it. For a buy that needs designed banners:

- **One headline, one button, one colour.** The longest-running banner in the scan (shown 1,515 days) is 6 words, a circular photo, a logo and one orange button, and names no date or offer.
- **Set the headline big.** 11 to 17% of the width per line on 300x250 and 300x600; 25 to 30% of the height per line on 728x90.
- **Small sizes survive by subtraction.** 728x90 carries 8 to 14 words at most: logo on the left, 2 lines in the middle, the CTA on the right. A 300x250 can drop the image and the button and still read: plain type on one colour on one strong left margin.
- **Tall to strip.** When one campaign goes from 300x600 to 728x90, the logo moves from the bottom to the far left, the headline from the top to the far right, 4 lines become 2, and nothing is added. Check every strip after Smart Resize and adjust it in the Studio if it does not read.
- **A zoomed UI snippet reads at 90 px.** For a SaaS leaderboard, crop one chart and its number so far in that it fills the banner's height, inside a lens or circle that breaks the top and bottom edges.
- **A grid of real finished jobs** (3 to 5 photos) beside the headline is the proof for a local trade at 300x250.
- Fields: `headline`, `cta`, `logo`, `photo` or `ui_snippet`, `legal`.

## Anti-patterns seen on weaker ads

- A plain stock or team photo with no text when the business has a concrete offer: the price or "free estimate" is buried in the ad text.
- A lifestyle photo with a small serif title and a logo: reads as a brand post, not an ad. Low contrast, tiny type, no number.
- Overloaded frames: brand, tagline, 4 captions, urgency, 3 icons and a stat bar on one before and after.
- Legal text at 1 to 2% of the width filling the bottom 10%, or placed in the story safe zone.
- An empty half canvas, or centred type with no image anchor.
- Low-resolution logos and screenshots blown up until the text is unreadable.
- Stale dates in evergreen offers; the wrong language for the market.
- Faces that look generated repeat across advertisers now; use the user's own photos, or stock of a real person.
- Generic stock people on a gradient with a soft hook and no number or proof object.
- A video poster saved as a static: a black or blank first frame. A static has to look finished.
- On Google responsive display: a photo crop that cuts the subject, or a tall slot with a dead middle third because the image was too wide.
- Feed-built product grids where names are cut off mid-word and the brand is a tiny favicon.
