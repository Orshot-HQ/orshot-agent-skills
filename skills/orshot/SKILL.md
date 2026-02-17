---
name: orshot
description: Generate images, PDFs, and videos programmatically using the Orshot API. Use when building visual content automation, marketing image generation, certificate/invoice PDFs, social media carousels, or video generation from templates.
metadata:
  author: daskrad
  version: "1.0.0"
---

# Orshot – Automated Visual Content Generation

[Orshot](https://orshot.com) is an automated image, PDF, and video generation platform. Design templates in Orshot Studio (or import from Canva/Figma), then generate renders via REST API, SDKs, or no-code integrations.

**Documentation:** https://orshot.com/docs
**API Base URL:** `https://api.orshot.com/v1`

## When to Use This Skill

Use this skill when:

- Generating images, PDFs, or videos programmatically from templates
- Building automated marketing visual pipelines
- Creating dynamic social media content (carousels, posts, stories)
- Generating certificates, invoices, tickets, or reports as PDFs
- Building image generation APIs for SaaS products
- Automating visual content with Zapier, Make, n8n, or Airtable
- Embedding a design editor into an application
- Working with Orshot API, SDKs, or integrations

## Authentication

All API requests require a Bearer token in the `Authorization` header:

```
Authorization: Bearer <ORSHOT_API_KEY>
```

[Get your API key](https://orshot.com/docs/quick-start/get-api-key) from **Workspace Settings → API Keys** in the Orshot dashboard.

## Core API Endpoints

### 1. Render from Studio Template

Generate images/PDFs/videos from templates designed in Orshot Studio.

**POST** `https://api.orshot.com/v1/studio/render`

```js
await fetch("https://api.orshot.com/v1/studio/render", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    Authorization: "Bearer <ORSHOT_API_KEY>",
  },
  body: JSON.stringify({
    templateId: 123, // Integer - your studio template ID
    modifications: {
      title: "Hello World",
      imageUrl: "https://example.com/photo.jpg",
      canvasBackgroundColor: "#eff2fa",
    },
    response: {
      type: "base64", // "base64" | "url" | "binary"
      format: "png", // "png" | "webp" | "jpg" | "pdf" | "mp4" | "webm" | "gif"
      scale: 1, // 1 = original size, 2 = double
      includePages: [1, 3], // optional – only for multi-page templates
      fileName: "my-render", // optional – custom filename (without extension)
    },
    pdfOptions: {
      // optional – only when format is "pdf"
      margin: "20px",
      rangeFrom: 1,
      rangeTo: 2,
      colorMode: "rgb", // "rgb" or "cmyk"
      dpi: 300,
    },
  }),
});
```

**Response (single page):**

```json
{
  "data": {
    "content": "data:image/png;base64,iVBORw0.....",
    "format": "png",
    "type": "base64",
    "responseTime": 325.22
  }
}
```

**Response (multi-page/carousel):**

```json
{
  "data": [
    { "page": 1, "content": "https://storage.orshot.com/.../image1.png" },
    { "page": 2, "content": "https://storage.orshot.com/.../image2.png" }
  ],
  "format": "png",
  "type": "url",
  "responseTime": 3166.01,
  "totalPages": 2,
  "renderedPages": 2
}
```

### 2. Render from Utility Template

Generate renders from Orshot's pre-built utility templates (e.g., website screenshots, tweet images).

**POST** `https://api.orshot.com/v1/generate/{renderType}`

- `renderType`: `images` or `pdfs`

```js
await fetch("https://api.orshot.com/v1/generate/images", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    Authorization: "Bearer <ORSHOT_API_KEY>",
  },
  body: JSON.stringify({
    templateId: "website-screenshot", // String ID for utility templates
    response: {
      format: "png",
      type: "base64",
    },
    modifications: {
      websiteUrl: "https://example.com",
      fullCapture: false,
      delay: 500,
      width: 1200,
      height: 1000,
    },
  }),
});
```

### 3. Generate Signed URL

Create publicly accessible render URLs without exposing your API key.

**POST** `https://api.orshot.com/v1/signed-url/create`

```js
await fetch("https://api.orshot.com/v1/signed-url/create", {
  method: "POST",
  headers: {
    Authorization: "Bearer <ORSHOT_API_KEY>",
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    templateId: "website-screenshot",
    expiresAt: 1744550160505, // UNIX timestamp, or null for no expiry
    renderType: "images",
    modifications: {
      websiteUrl: "https://example.com",
    },
  }),
});
```

### 4. List Studio Templates

**GET** `https://api.orshot.com/v1/studio/templates/all?page=1&limit=10`

```js
await fetch("https://api.orshot.com/v1/studio/templates/all?page=1&limit=10", {
  method: "GET",
  headers: {
    "Content-Type": "application/json",
    Authorization: "Bearer <ORSHOT_API_KEY>",
  },
});
```

Response includes `data` array of templates and `pagination` object with `page`, `limit`, `total`, `totalPages`.

### 5. Get Studio Template

**GET** `https://api.orshot.com/v1/studio/templates/:templateId`

Returns the template metadata including available `modifications` with their `key`, `type` (text/image), `helpText`, and `example` values.

### 6. Delete Studio Template

**DELETE** `https://api.orshot.com/v1/studio/templates/:templateId`

### 7. Duplicate Studio Template

**POST** `https://api.orshot.com/v1/studio/templates/:templateId/duplicate`

### 8. Get Workspace Profile

**GET** `https://api.orshot.com/v1/profile/workspace`

Returns workspace details, plan info, and render usage.

## Brand Assets API

### Upload Brand Asset

**POST** `https://api.orshot.com/v1/brand-assets/upload`

Upload as `multipart/form-data` with a `file` field. Max 5MB, supports PNG, JPG, JPEG, SVG, WEBP, GIF.

### Get Brand Assets

**GET** `https://api.orshot.com/v1/brand-assets`

### Delete Brand Asset

**DELETE** `https://api.orshot.com/v1/brand-assets/:assetId`

## Enterprise API Endpoints

These endpoints require an Enterprise plan.

### Create Studio Template

**POST** `https://api.orshot.com/v1/studio/templates/create`

```js
{
  name: "Product Banner",        // required, max 255 chars
  description: "Banner template", // optional
  canvas_width: 1200,             // required, 1-5000
  canvas_height: 628,             // required, 1-5000
  pages_data: [...]               // optional - array of page objects with elements
}
```

### Bulk Create Studio Templates

**POST** `https://api.orshot.com/v1/studio/templates/bulk-create`

Create multiple templates at once via CSV or JSON.

### Update Template

**PATCH** `https://api.orshot.com/v1/studio/templates/:templateId`

Update template name and description.

### Update Template Modifications

**PATCH** `https://api.orshot.com/v1/studio/templates/:templateId/update-modifications`

Update text and image content in template layers:

```js
{
  data: [
    {
      page: 1,
      modifications: {
        headline: "New Headline",
        product_image: "https://cdn.example.com/new.png",
      },
    },
  ];
}
```

### Generate Template Variants

**POST** `https://api.orshot.com/v1/studio/templates/:templateId/generate-variants`

Generate multiple size variants of a template using AI.

## Dynamic Parameters

Override template styles, content, and behavior at render time using dot notation.

### Style Parameters

Format: `parameterId.property`

```json
{
  "modifications": {
    "title": "Hello World",
    "title.fontSize": "48px",
    "title.color": "#ff0000",
    "title.fontFamily": "Roboto",
    "title.textAlign": "center",
    "logo.borderRadius": "50%",
    "logo.objectFit": "cover"
  }
}
```

**Text properties:** `fontSize`, `fontWeight`, `fontStyle`, `fontFamily`, `lineHeight`, `letterSpacing`, `textAlign`, `verticalAlign`, `textDecoration`, `textTransform`, `color`, `backgroundColor`, `backgroundRadius`, `textStrokeWidth`, `textStrokeColor`, `opacity`, `filter`, `dropShadowX/Y/Blur/Color`

**Image properties:** `objectFit`, `objectPosition`, `borderRadius`, `borderWidth`, `borderColor`, `boxShadowX/Y/Blur/Color`, `opacity`, `filter`

**Shape properties:** `fill`, `stroke`, `strokeWidth`, `borderRadius`, `opacity`

**Position/Size (all elements):** `x`, `y`, `width`, `height`

Property names are **case-insensitive**.

### Multi-Page Templates

Prefix modifications with page number:

```json
{
  "modifications": {
    "page1@title": "Page 1 Title",
    "page2@title": "Page 2 Title",
    "page1@title.fontSize": "48px"
  }
}
```

### AI Content Generation (.prompt)

Generate text or images using AI:

```json
{
  "modifications": {
    "headline.prompt": "Write a catchy headline about coffee",
    "background.prompt": "A serene mountain landscape at sunset"
  }
}
```

- Text elements use `openai/gpt-5-nano`
- Image elements use `google/nano-banana`
- Only works on text and image elements

### Interactive Links (.href)

Add clickable links in PDF outputs:

```json
{
  "modifications": {
    "cta_button.href": "https://example.com/signup",
    "logo.href": "https://company.com"
  },
  "response": { "format": "pdf" }
}
```

Only works with `http://` or `https://` URLs in PDF format.

### Video Parameters

Control video elements dynamically:

```json
{
  "modifications": {
    "bgVideo": "https://example.com/video.mp4",
    "bgVideo.trimStart": 5,
    "bgVideo.trimEnd": 15,
    "bgVideo.muted": false,
    "bgVideo.loop": true
  },
  "response": { "format": "mp4" }
}
```

## Video Generation

Render templates with video elements as MP4, WebM, or GIF:

```js
await fetch("https://api.orshot.com/v1/studio/render", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    Authorization: "Bearer <ORSHOT_API_KEY>",
  },
  body: JSON.stringify({
    templateId: 123,
    modifications: {
      videoElement: "https://example.com/custom-video.mp4",
      "videoElement.trimStart": 0,
      "videoElement.trimEnd": 10,
      "videoElement.muted": false,
      "videoElement.loop": true,
    },
    videoOptions: {
      trimStart: 0,
      trimEnd: 20,
      muted: true,
      loop: true,
    },
    response: {
      type: "url",
      format: "mp4",
    },
  }),
});
```

## SDKs

### Node.js

```bash
npm install orshot
```

```js
import { Orshot } from "orshot";
const orshot = new Orshot("<ORSHOT_API_KEY>");

// Render from template
const response = await orshot.renderFromTemplate({
  templateId: "open-graph-image-1",
  modifications: { title: "Hello World" },
  responseType: "base64", // "base64" | "url" | "binary"
  responseFormat: "png", // "png" | "webp" | "jpg" | "pdf"
});

// Generate signed URL
const signedUrl = await orshot.generateSignedUrl({
  templateId: "open-graph-image-1",
  modifications: { title: "Hello" },
  expiresAt: 1744276943,
  renderType: "images",
  responseFormat: "png",
});
```

### Python

```bash
pip install orshot
```

```python
import orshot
os = orshot.Orshot('<ORSHOT_API_KEY>')

response = os.render_from_template({
  'template_id': 'open-graph-image-1',
  'modifications': {'title': 'Hello World'},
  'response_type': 'base64',
  'response_format': 'png'
})
```

### Other SDKs

- **PHP:** `composer require nicholasgriffintn/orshot-php`
- **Ruby:** `gem install orshot`

## Response Types

| Type     | Description                                     |
| -------- | ----------------------------------------------- |
| `url`    | Returns a hosted URL to the rendered file       |
| `base64` | Returns base64-encoded content as a string      |
| `binary` | Returns binary file content for custom handling |

## Response Formats

| Format | Type  | Notes                                      |
| ------ | ----- | ------------------------------------------ |
| `png`  | Image | Best quality, larger size                  |
| `webp` | Image | Smaller size, good quality                 |
| `jpg`  | Image | Compressed, no transparency                |
| `pdf`  | Doc   | Supports multi-page, clickable links, CMYK |
| `mp4`  | Video | H.264, requires video elements in template |
| `webm` | Video | VP9, web-optimized                         |
| `gif`  | Video | Animated, no audio support                 |

## Render Usage

| Output               | Cost                 |
| -------------------- | -------------------- |
| Image (PNG/JPG/WebP) | 2 renders per image  |
| PDF                  | 2 renders per page   |
| Video (MP4/WebM/GIF) | 2 renders per second |

Multi-page templates: each page counts separately.

## Dynamic URLs

Generate images directly from URL parameters:

```
https://api.orshot.com/v1/studio/dynamic-url/my-image?title=Hello%20World&title.fontSize=48px&title.color=%23ff0000
```

URL-encode special characters (e.g., `#` → `%23`).

## Common Error Codes

| Code | Error                          | Fix                                          |
| ---- | ------------------------------ | -------------------------------------------- |
| 400  | `templateId missing`           | Add `templateId` to request body             |
| 400  | `Invalid API Key`              | Generate new key from dashboard              |
| 403  | `Authorization header missing` | Add `Authorization: Bearer <KEY>` header     |
| 403  | `Subscription inactive`        | Check usage or upgrade plan                  |
| 403  | `Template not found`           | Verify template ID belongs to your workspace |
| 403  | `Video on free plan`           | Upgrade to paid plan for video generation    |

## Integrations

Orshot connects with:

- **No-code:** Zapier, Make (Integromat), n8n, Pipedream, Airtable
- **Storage:** Amazon S3, Cloudflare R2, Google Drive, Dropbox
- **Notifications:** Slack, Webhooks
- **Design:** Figma Plugin, Canva Import, Polotno Import
- **CLI:** `npx orshot-cli` for terminal-based generation
- **MCP Server:** Use with Claude, Cursor, Windsurf via MCP protocol
- **Embed:** White-label design editor for your app (React SDK, Vue SDK, iframe)

## Best Practices

1. **Use `url` response type** for production – avoids large base64 payloads
2. **Use `webp` format** for smaller file sizes with good quality
3. **Test in Playground** before coding – each template has an interactive playground
4. **Use style parameters** instead of creating multiple template variants
5. **Use consistent units** – stick to `px` for sizes
6. **Multi-page prefix** – always use `page1@paramId` format for carousel templates
7. **Cache renders** – use `?cache=false` query param to bypass cache when needed
8. **Handle errors** – check for 403/400 status codes and parse error messages

## Links

- Documentation: https://orshot.com/docs
- API Reference: https://orshot.com/docs/api-reference
- Templates: https://orshot.com/templates
- Studio: https://orshot.com/studio
- Pricing: https://orshot.com/pricing
- SDKs: https://orshot.com/docs/sdks
- Integrations: https://orshot.com/docs/integrations
- MCP Server: https://orshot.com/docs/integrations/mcp-server
