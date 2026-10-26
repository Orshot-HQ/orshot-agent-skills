# Thumbnail layouts at 1280x720

Five layouts for `orshot_create_template_design` with `canvas_width: 1280`, `canvas_height: 720`. Each one keeps the bottom-right corner (about 200x80px) free of words, because YouTube shows the video length there. Swap the placeholder colors and fonts for the brand kit's. Replace every `{{...}}` with a real public URL or a `stock://` ref before you send it.

Field names, value formats and the parameterType for each layer kind are in the MCP resource `orshot://template-design-spec` and at https://orshot.com/docs/definitions/template-json.md. For general design craft, load the orshot-design skill.

Craft that holds for all five:

- Condensed, heavy display fonts read best small: Anton, Bebas Neue, Oswald, Archivo Black. One display font, at most one more.
- Every text layer uses the Fit text mode with a minimum font size, so a long hook shrinks instead of spilling out.
- Words over a photo get a dark gradient shape behind them, or a text stroke.

## 1. Face + big words (default)

Words left, face right, accent box under the first line.

```json
[
  {
    "name": "Face + big words",
    "canvas": { "width": 1280, "height": 720, "backgroundColor": "#111111" },
    "elements": [
      { "id": "background", "type": "image", "content": "{{BACKGROUND_URL}}",
        "position": { "x": 0, "y": 0 }, "dimensions": { "width": 1280, "height": 720 },
        "style": { "objectFit": "cover" }, "zIndex": 1,
        "parameterizable": true, "parameterId": "background", "parameterType": "imageUrl" },
      { "id": "scrim", "type": "shape", "shapeType": "rectangle",
        "position": { "x": 0, "y": 0 }, "dimensions": { "width": 1280, "height": 720 },
        "style": { "fill": "linear-gradient(90deg, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0.55) 45%, rgba(0,0,0,0) 75%)" },
        "zIndex": 2 },
      { "id": "accent", "type": "shape", "shapeType": "rectangle",
        "position": { "x": 56, "y": 372 }, "dimensions": { "width": 600, "height": 176 },
        "style": { "fill": "#FFD400", "borderRadius": "18px" }, "zIndex": 3,
        "parameterizable": true, "parameterId": "accent", "parameterType": "fill" },
      { "id": "headline", "type": "text", "content": "$20 BEATS",
        "position": { "x": 64, "y": 176 }, "dimensions": { "width": 600, "height": 180 },
        "style": { "fontFamily": "Anton", "fontSize": "160px", "fontWeight": "400", "lineHeight": 1.0,
                   "color": "#FFFFFF", "textAlign": "left", "verticalAlign": "flex-end",
                   "textTransform": "uppercase", "textStrokeColor": "#000000", "textStrokeWidth": "4px",
                   "textMode": "fit", "minFontSize": "90" },
        "zIndex": 4, "parameterizable": true, "parameterId": "headline", "parameterType": "text" },
      { "id": "headline_accent", "type": "text", "content": "$400?",
        "position": { "x": 80, "y": 384 }, "dimensions": { "width": 552, "height": 152 },
        "style": { "fontFamily": "Anton", "fontSize": "150px", "fontWeight": "400", "lineHeight": 1.0,
                   "color": "#111111", "textAlign": "left", "verticalAlign": "center",
                   "textTransform": "uppercase", "textMode": "fit", "minFontSize": "80" },
        "zIndex": 5, "parameterizable": true, "parameterId": "headline_accent", "parameterType": "text" },
      { "id": "subject", "type": "image", "content": "{{FACE_CUTOUT_URL}}",
        "position": { "x": 640, "y": 40 }, "dimensions": { "width": 640, "height": 680 },
        "style": { "objectFit": "contain", "dropShadowY": "8px", "dropShadowBlur": "24px",
                   "dropShadowColor": "rgba(0,0,0,0.45)" },
        "zIndex": 6, "parameterizable": true, "parameterId": "subject", "parameterType": "imageUrl" }
    ]
  }
]
```

Mirror it (words right, face left) for a second series so two series never look the same.

## 2. Before / after split

| Layer | parameterId | Box (x, y, w, h) | Notes |
|---|---|---|---|
| Left image | `before_image` | 0, 0, 640, 720 | fills its half |
| Right image | `after_image` | 640, 0, 640, 720 | fills its half |
| Divider | `accent` | 632, 0, 16, 720 | shape, brand color |
| Label pill left | `before_label` | 48, 48, 260, 96 | "BEFORE", dark box behind |
| Label pill right | `after_label` | 972, 48, 260, 96 | "AFTER", accent box behind |
| Headline (optional) | `headline` | 140, 520, 1000, 150 | 2 to 3 words, centered, stroke |
| Face (optional) | `subject` | 470, 260, 340, 460 | cutout on the seam, over the divider |

Keep the right label clear of the timestamp: the headline sits bottom-center, not bottom-right.

## 3. Number / list

| Layer | parameterId | Box (x, y, w, h) | Notes |
|---|---|---|---|
| Ground | `ground_color` | 0, 0, 1280, 720 | flat brand color shape |
| Number box | `accent` | 56, 96, 470, 528 | shape, brand color, rounded corners |
| Number | `number` | 56, 96, 470, 528 | as big as the box allows, centered |
| Headline | `headline` | 580, 120, 640, 260 | 2 to 3 words, 2 lines max |
| Object | `subject` | 640, 360, 420, 330 | product or cutout, contained in its box |

Want a photo ground instead of a flat color? Use an image layer named `background`, as in layout 1, so one field name always means one kind of value.

## 4. Screenshot + reaction

| Layer | parameterId | Box (x, y, w, h) | Notes |
|---|---|---|---|
| Ground | `ground_color` | 0, 0, 1280, 720 | dark or brand color shape |
| Card | `screenshot` | 64, 120, 760, 480 | cover-fit image, rounded corners, tilted 3 degrees left (rotation 357), drop shadow |
| Headline | `headline` | 64, 24, 760, 120 | 2 to 3 words over the card's top edge, accent box or stroke |
| Face | `subject` | 700, 80, 580, 640 | cutout, overlaps the card's right edge by about 120px |

The screenshot must be the user's own product, their own post, or something they may show. Never a fake screenshot.

## 5. Screenshot + name

A real screenshot carries the picture and the name carries the click. For gaming builds, guides, patch notes and tutorials, where viewers want to see the actual game or app.

| Layer | parameterId | Box (x, y, w, h) | Notes |
|---|---|---|---|
| Screenshot | `background` | 0, 0, 1280, 720 | the user's own capture, cover-fit |
| Scrim | none | 0, 0, 1280, 720 | gradient shape, dark on the left and bottom, clear on the right |
| Accent box (optional) | `accent` | 56, 300, 420, 96 | shape, brand color, behind `headline_accent` |
| Tag (optional) | `headline_accent` | 72, 308, 388, 80 | 1 to 2 words, for example "TIER S" |
| Name | `headline` | 56, 410, 900, 220 | 2 to 4 words, the build or feature name, stroke, 2 lines max |
| Face (optional) | `subject` | 960, 40, 300, 340 | small cutout, top right, so the bottom-right timestamp corner stays clear |

Same field names as layout 1, so a channel can switch between the two templates without changing its automation.
