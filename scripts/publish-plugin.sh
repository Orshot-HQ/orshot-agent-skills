#!/usr/bin/env bash
# Publish the bundle plugin (openclaw.plugin.json + skills + hosted MCP server) to ClawHub
# under the @orshot owner as `orshot` (install: openclaw plugins install clawhub:orshot).
# Bump "version" in every manifest first (./scripts/check.sh verifies they agree).
# The catalog category comes from "categories" in openclaw.plugin.json; ClawHub ignores
# --categories for plugins.
# Pass --dry-run to only print.
set -euo pipefail
cd "$(dirname "$0")/.."
OWNER="${CLAWHUB_OWNER:-orshot}"
CLAWHUB="${CLAWHUB:-$(command -v clawhub || echo "npx -y clawhub@0.23.3")}"
VERSION="$(python3 -c 'import json;print(json.load(open("openclaw.plugin.json"))["version"])')"
PKG_VERSION="$(python3 -c 'import json;print(json.load(open("package.json"))["version"])')"
if [[ "$VERSION" != "$PKG_VERSION" ]]; then
  echo "openclaw.plugin.json ($VERSION) and package.json ($PKG_VERSION) versions differ. Run ./scripts/check.sh." >&2; exit 1
fi
COMMIT="$(git rev-parse HEAD 2>/dev/null || echo uncommitted)"
REF="$(git describe --tags --exact-match 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || echo main)"
if [[ -n "$(git status --porcelain)" && "${1:-}" != "--dry-run" ]]; then
  echo "Working tree is not clean. Commit first so provenance points at a real commit." >&2; exit 1
fi
$CLAWHUB package validate . --out "${TMPDIR:-/tmp}/orshot-plugin-reports" >/dev/null
$CLAWHUB package publish . \
  --family bundle-plugin \
  --name orshot \
  --display-name "Orshot: image, PDF and video generation from templates, with one skill per use case" \
  --owner "$OWNER" \
  --version "$VERSION" \
  --changelog "Bundle plugin $VERSION: hosted Orshot MCP server (OAuth) plus every skill in skills/ ($(ls skills | paste -sd, -))" \
  --topics "image-generation,pdf-generation,video-generation,social-media-scheduler,mcp" \
  --source-repo Orshot-HQ/orshot-agent-skills \
  --source-commit "$COMMIT" \
  --source-ref "$REF" \
  ${1:-}
