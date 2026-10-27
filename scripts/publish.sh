#!/usr/bin/env bash
# Publish every skill in skills/ to ClawHub at the version in its SKILL.md frontmatter.
# Skips a skill when that version is already on ClawHub. Pass --dry-run to only print.
#
# Needs: clawhub CLI (npm install -g clawhub@0.23.3) and a login (clawhub login).
# Display names below carry the phrases people search for on ClawHub; keep them in sync
# with the frontmatter descriptions. ClawHub allows at most 5 topics per skill.
set -euo pipefail

cd "$(dirname "$0")/.."

OWNER="${CLAWHUB_OWNER:-orshot}"
CLAWHUB="${CLAWHUB:-$(command -v clawhub || echo "npx -y clawhub@0.23.3")}"
REPO="Orshot-HQ/orshot-agent-skills"
COMMIT="$(git rev-parse HEAD 2>/dev/null || echo uncommitted)"
REF="$(git describe --tags --exact-match 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || echo main)"
DRY_RUN=""
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN="--dry-run"

if [[ -n "$(git status --porcelain)" && -z "$DRY_RUN" ]]; then
  echo "Working tree is not clean. Commit first so provenance points at a real commit." >&2
  exit 1
fi

display_name() {
  case "$1" in
    orshot) echo "Orshot: image, PDF and video generation API and MCP server for templates (render, batch, Smart Resize, dynamic URLs, n8n, Make, Zapier)" ;;
    orshot-social-media-scheduler) echo "Orshot Social Media Scheduler: schedule and auto-post to Instagram, TikTok, LinkedIn, X, Facebook, YouTube, Pinterest, Threads, Bluesky, Reddit, Telegram, Snapchat and Google Business from templates" ;;
    orshot-carousel) echo "Orshot TikTok Slideshow and Carousel Generator: faceless TikTok slideshows, Instagram carousels and LinkedIn carousels from a template" ;;
    orshot-social-media-content) echo "Orshot Social Media Post Generator: on-brand Instagram, LinkedIn, Facebook and X posts, stories and quote cards from templates, a Canva alternative by API" ;;
    orshot-design) echo "Orshot Design: on-brand template design rules for images, ads, thumbnails and video" ;;
    orshot-blog-images) echo "Orshot Blog Images: featured image and OG image generator for WordPress, Ghost and Next.js blogs, from templates" ;;
    orshot-video-generator) echo "Orshot Video Generator: Reels, Shorts, product and listing videos and animated chart films from a template" ;;
    orshot-ad-creative) echo "Orshot Ad Creative Generator: static Meta ads, test variations and catalog ads in every size" ;;
    orshot-youtube-thumbnail) echo "Orshot YouTube Thumbnail Maker: your channel's style, your own frames and face, A/B variants" ;;
    orshot-pdf-generator) echo "Orshot PDF Generator: invoice, certificate and report PDFs from a template and sheet data via API, n8n, Make or Zapier" ;;
    *) echo "$1" ;;
  esac
}


# ClawHub category slugs (max 3): integrations, automation, research, development, productivity,
# communication, creative, knowledge, agents, operations, security, finance, lifestyle, other.
categories() {
  case "$1" in
    orshot) echo "creative,automation,integrations" ;;
    orshot-social-media-scheduler) echo "communication,automation,productivity" ;;
    orshot-carousel) echo "creative,communication,automation" ;;
    orshot-social-media-content) echo "creative,productivity,automation" ;;
    orshot-design) echo "creative,productivity" ;;
    orshot-blog-images) echo "creative,productivity,automation" ;;
    orshot-video-generator) echo "creative,automation,productivity" ;;
    orshot-ad-creative) echo "creative,automation,productivity" ;;
    orshot-youtube-thumbnail) echo "creative,productivity,automation" ;;
    orshot-pdf-generator) echo "automation,productivity,integrations" ;;
  esac
}

topics() {
  case "$1" in
    orshot) echo "image-generation,pdf-generation,video-generation,templates,mcp-server" ;;
    orshot-social-media-scheduler) echo "social-media-scheduler,auto-post,schedule-posts,social-media-automation,instagram" ;;
    orshot-carousel) echo "tiktok-slideshow,tiktok-carousel,instagram-carousel,linkedin-carousel,carousel" ;;
    orshot-social-media-content) echo "social-media-post-generator,social-media-content,instagram-post,linkedin-post,canva-alternative" ;;
    orshot-design) echo "design,templates,brand,image-generation,video-generation" ;;
    orshot-blog-images) echo "featured-image,og-image,blog-images,wordpress,image-generation" ;;
    orshot-video-generator) echo "video-generation,reels,youtube-shorts,faceless-video,video-automation" ;;
    orshot-ad-creative) echo "ad-creative,meta-ads,static-ads,ad-variations,banner-generator" ;;
    orshot-youtube-thumbnail) echo "youtube-thumbnail,thumbnail-maker,thumbnail-template,ab-testing,youtube-automation" ;;
    orshot-pdf-generator) echo "pdf-generator,invoice-generator,certificate-generator,document-generation,n8n" ;;
  esac
}

for dir in skills/*/; do
  slug="$(basename "$dir")"
  version="$(sed -n 's/^  version: "\(.*\)"/\1/p' "$dir/SKILL.md" | head -1)"
  [[ -z "$version" ]] && { echo "$slug: no metadata.version in frontmatter" >&2; exit 1; }

  published="$(curl -sf "https://clawhub.ai/api/v1/skills/$slug" | sed -n 's/.*"latestVersion":{"version":"\([^"]*\)".*/\1/p' || true)"
  if [[ "$published" == "$version" ]]; then
    echo "$slug $version already published, skipping"
    continue
  fi

  changelog="$(awk -v s="### $slug $version" '$0==s{f=1;next} f&&/^### /{exit} f&&/^- /{print}' CHANGELOG.md | sed 's/^- //' | paste -sd ';' -)"
  [[ -z "$changelog" ]] && changelog="Version $version"

  echo "publishing $slug $version (was ${published:-unpublished})"
  $CLAWHUB skill publish "$dir" \
    --slug "$slug" \
    --name "$(display_name "$slug")" \
    --owner "$OWNER" \
    --version "$version" \
    --changelog "$changelog" \
    --categories "$(categories "$slug")" \
    --topics "$(topics "$slug")" \
    --source-repo "$REPO" \
    --source-commit "$COMMIT" \
    --source-ref "$REF" \
    --source-path "${dir%/}" \
    $DRY_RUN
done

[[ -n "$DRY_RUN" ]] && exit 0
echo
echo "Audit reports:"
for dir in skills/*/; do
  slug="$(basename "$dir")"
  version="$(sed -n 's/^  version: "\(.*\)"/\1/p' "$dir/SKILL.md" | head -1)"
  echo "  $CLAWHUB scan --slug $slug --version $version --json"
done
