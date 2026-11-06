# Worked example: a feature launch film (16:9, 32 s)

Orshot's own launch film for colour grading in its template editor. Eight scenes: five built from real screenshots of the product, two on what else shipped, and an end card. Use it as the bar for every launch or feature film: the product is on screen doing a real job, every scene has one action and its result, and the ground is never flat.

Look: ink `#0E0F14`, paper `#F4F2EE`, blue `#4C63F6`, an amber glow `#F2A65A`. Fonts: Bricolage Grotesque 700 (headlines, labels) with one Instrument Serif italic accent word per headline, JetBrains Mono for code. Music: a cinematic "reveal" bed from the library, found by searching for the mood, not the default pick.

Field shapes and motion keys are in `orshot_get_design_spec` topics `film` and `template-json`. The snippets below are excerpts of the real template, trimmed to the keys that matter.

## The captures

All screens are 2x captures of the editor in its full three-column layout, with a real poster open (a café's "Autumn Roast" poster: headline, price pill, footer), so the film reads as a template editor and not a photo editor.

- One capture per state: before; after each of four slider changes; each of six looks picked; a second poster before, with the panel open, with the look picked, and closed.
- Every state of one scene is captured in the same session, so the panel sits in the same place. When one capture still shifts (here a panel moved 10 px when its button gained a dot), it is corrected before upload.
- Close-ups are the same crop of each capture (here 1962 x 1742 px from a 2602 x 1862 capture). Uploaded once each, then placed as image layers.

## The timeline

| Film time | Scene | What lands |
|---|---|---|
| 0.0 | Hook (4.0 s) | The whole editor rises 160 px into place as a card (0.95 s, `expo.out`) under the headline "Grade the photos in your *templates.*", which reveals by word (mask). |
| 1.75 | | A white edge sweeps across the poster photo (0.95 s): the graded capture is revealed behind it by a clip that follows the edge. |
| 3.2 | Cut | `push` left (0.8 s). |
| 3.2 | Adjust (5.4 s) | The close-up slides in from the right. "Adjust light and *colour.*" reveals. A tone curve draws in under it (1.2 s). |
| + 1.15, 2.0, 2.85, 3.55 | | The pointer glides to a value, presses, a ring pulses, a click sounds, and the next capture crossfades in (0.32 s): exposure, shadows, warmth, vibrance. A label pill rises with each of the first three ("Brighten", "Lift shadows", "Warm it up"). |
| 7.8 | Filters (5.3 s) | The close-up slides in from the left with the looks grid open. "12 looks. *One click.*" |
| + 1.0 to 3.6 | | The pointer hops across six looks 0.52 s apart; each click crossfades the next capture (0.14 s) and pops that look's colour swatch beside the headline. |
| 12.3 | Page grade (5.4 s) | The second poster. The pointer opens the page grade (0.95), picks a look (1.9): all three photos change at once. "Whole poster, one look" pill. The panel closes on the graded poster (3.0). |
| 16.9 | Proof (5.2 s) | The API panel slides in with the grade lines boxed. "Every look is an *API field.*" Three real renders of the same poster, one per look, fly in from the panel 0.32 s apart, each labelled with its value (`"warm-film"`, `"noir"`, `"brand-duotone"`). |
| 21.3 | Agents (4.9 s) | Light ground. Five finished agent designs fan in (`back.out(1.4)`). "Agents make better *templates* too." |
| 25.4 | Up close (4.8 s) | One design large, three hand-drawn arrows draw in 0.8 s apart with what makes it good: "Photo graded to the brief", "Real ad details", "Fonts that pair". |
| 29.2 | End (3.2 s) | `colorFlood` in blue, the wordmark settles from a blur, "Colour grading, *now in Orshot.*", the URL pill. One logo-reveal sound builds through the flood and hits as the wordmark lands. |

## The layers that make it look designed

Every scene, bottom to top: a dot grid that fades to the edges, two soft colour glows drifting slowly, thin corner crop marks, the screenshot card with a deep shadow, the pointer and rings, then type.

The screenshot stack. Every capture of the scene carries the same `groupId`; the group moves, each capture only fades:

```json
"motion": { "groups": { "cam": { "keyframes": [
  { "at": 0, "x": 140, "y": 0, "scale": 0.96, "rotate": 0, "opacity": 0 },
  { "at": 0.95, "x": 0, "y": 0, "scale": 1, "rotate": 0, "opacity": 1, "ease": "expo.out" },
  { "at": 5.4, "x": 0, "y": 0, "scale": 1.045, "rotate": 0, "opacity": 1, "ease": "none" }
] } } }
```

```json
{ "id": "adj_s1", "type": "image", "groupId": "cam", "content": "<capture after exposure>",
  "motion": { "keyframes": [ { "at": 1.37, "opacity": 0 }, { "at": 1.69, "opacity": 1 } ] } }
```

The camera lives on the group because a keyframe that leaves a channel out returns it to rest: an opacity fade and a push on the same layer would fight.

The pointer is a small inline SVG arrow in the same group. Its keyframes repeat `x`, `y` and `scale` on every stop (glide `power3.inOut`, press to 0.84 for 0.12 s on arrival), and its `sound.at` holds one click per press, the same click every time. A ring (a stroked circle SVG) scales 0.3 to 1.25 and fades on each press.

The sweep is the after capture over the before one, with a clip that opens from the photo's left edge to its right edge in step with a 4 px white edge layer that has a white glow.

## What changed between versions

- Stock footage and stock photos for the feature scenes looked generic. Real screenshots fixed it.
- A bare photo on the canvas read as a photo editor. A real poster with type, price and footer reads as a template editor.
- Inter on a flat dark ground read plain. A display face with an italic serif accent word, a patterned ground and one motif per scene fixed it.
- Pills that sat left of the headline: a text background's padding draws outside the layer, so a pill is placed its padding to the right of the headline's x.
- Effects picked for variety (four click takes, a different whoosh per card) read as random. One sound per action for the whole film: every press the same click, every cut of a type the same whoosh, a different sound for each different action.
- A short swish under a 0.95 s shine sweep ended mid-move. Search with the motion's `duration` so the sound covers it, and the film's `style` (`cinematic` for a launch film) so no playful pop or bloop gets in.
- A sound on every press, pill and card (28 effects in 32 s) felt busy. Thinning per scene (15 effects) then left some presses clicking and others silent, which read as random too. What works: decide per action, not per instance. Every press clicks (13), every cut has the same whoosh (7), the shine sweep and each hand-drawn arrow have their sound; pills, fly-ins and the card fan are silent.
- A riser into the end card plus a logo reveal with its own build were two climaxes on top of each other. One logo-reveal sound whose hit lands with the wordmark, on a beat of the music, reads as one designed moment.
- A card that ran into the frame edge and a zoom cut that left a dot on the next scene: check frames from the render, not the JSON.
