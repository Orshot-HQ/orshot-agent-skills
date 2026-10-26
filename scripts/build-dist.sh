#!/usr/bin/env bash
# Build upload packages into dist/ (gitignored). Nothing is uploaded or published.
#
#   dist/claude-skills/<skill>.zip   One zip per skill for Claude.ai / Claude Desktop
#                                    (Customize > Skills > Upload). Each zip holds <skill>/SKILL.md
#                                    plus its references. Frontmatter keys outside the Agent Skills
#                                    spec (name, description, license, compatibility, metadata,
#                                    allowed-tools) are dropped from the zipped copy only, because
#                                    the uploader and skills-ref reject unknown keys. Sources stay as they are.
#   dist/openai/orshot-<version>.zip The portable plugin for the OpenAI plugin portal
#                                    (platform.openai.com/plugins, ChatGPT + Codex directory):
#                                    plugin.json, mcp.json, skills/, assets, README.md, LICENSE.
#                                    mcp.json in the zip gains the com.openai OAuth (DCR) declaration
#                                    the portal reads; the repo copy stays schema-pure Agent Plugins 1.0.0.
#
# Usage: ./scripts/build-dist.sh
set -euo pipefail
cd "$(dirname "$0")/.."

python3 -I - <<'PY'
import json, os, re, shutil, zipfile

ROOT = os.getcwd()
DIST = os.path.join(ROOT, "dist")
ALLOWED = {"name", "description", "license", "compatibility", "metadata", "allowed-tools"}
SKIP = {".DS_Store", "Thumbs.db", "desktop.ini"}
FIXED_TIME = (2026, 1, 1, 0, 0, 0)  # stable zip bytes between builds


def add_bytes(zf, arcname, data):
    info = zipfile.ZipInfo(arcname, FIXED_TIME)
    info.compress_type = zipfile.ZIP_DEFLATED
    info.external_attr = 0o644 << 16
    zf.writestr(info, data)


def walk(base):
    for dirpath, dirnames, filenames in os.walk(base):
        dirnames[:] = sorted(d for d in dirnames if not d.startswith(".") and d != "__MACOSX")
        for f in sorted(filenames):
            if f in SKIP:
                continue
            yield os.path.join(dirpath, f)


def sanitize_frontmatter(text, path):
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        raise SystemExit(f"{path}: no YAML frontmatter")
    kept, keep, dropped, section, nested = [], True, [], None, False
    for line in m.group(1).split("\n"):
        top = re.match(r"^([A-Za-z0-9_-]+):", line)
        if top:
            section = top.group(1)
            keep = section in ALLOWED
            if not keep:
                dropped.append(section)
        elif section == "metadata" and keep:
            # The spec's metadata is a map of string keys to string values. Keep `  key: value`
            # entries and drop nested client blocks (metadata.openclaw), which strict YAML
            # validators such as skills-ref reject and Claude does not read.
            child = re.match(r"^  ([A-Za-z0-9_-]+):\s*(.*)$", line)
            if child:
                nested = child.group(2) == ""
                if nested:
                    dropped.append(f"metadata.{child.group(1)}")
                    continue
            elif nested:
                continue
        if keep:
            kept.append(line)
    return "---\n" + "\n".join(kept) + "\n---\n" + text[m.end():], dropped


if os.path.isdir(DIST):
    shutil.rmtree(DIST)

# 1. One zip per skill for Claude.ai / Claude Desktop
out = os.path.join(DIST, "claude-skills")
os.makedirs(out)
for slug in sorted(os.listdir("skills")):
    sdir = os.path.join("skills", slug)
    if not os.path.isfile(os.path.join(sdir, "SKILL.md")):
        continue
    zpath = os.path.join(out, f"{slug}.zip")
    with zipfile.ZipFile(zpath, "w") as zf:
        for f in walk(sdir):
            rel = os.path.relpath(f, "skills")
            data = open(f, "rb").read()
            if os.path.basename(f) == "SKILL.md" and os.path.dirname(rel) == slug:
                text, dropped = sanitize_frontmatter(data.decode("utf-8"), f)
                data = text.encode("utf-8")
                if dropped:
                    print(f"  {slug}: dropped frontmatter keys {dropped} in the zip copy")
            add_bytes(zf, rel, data)
    print(f"built {os.path.relpath(zpath)}")

# 2. Portable plugin zip for the OpenAI plugin portal
manifest = json.load(open("plugin.json"))
version = manifest["version"]
mcp = json.load(open("mcp.json"))
for server in mcp["mcpServers"].values():
    server.setdefault("extensions", {})["com.openai"] = {"auth": {"type": "oauth", "client": {"mode": "dcr"}}}
iface = manifest.get("extensions", {}).get("com.openai", {}).get("interface", {})
assets = {p[2:] for p in (iface.get("composerIcon"), iface.get("logo")) if p}
os.makedirs(os.path.join(DIST, "openai"))
zpath = os.path.join(DIST, "openai", f"orshot-{version}.zip")
with zipfile.ZipFile(zpath, "w") as zf:
    add_bytes(zf, "plugin.json", open("plugin.json", "rb").read())
    add_bytes(zf, "mcp.json", (json.dumps(mcp, indent=2) + "\n").encode())
    for name in ["README.md", "LICENSE", *sorted(assets)]:
        add_bytes(zf, name, open(name, "rb").read())
    for f in walk("skills"):
        add_bytes(zf, os.path.relpath(f, ROOT), open(f, "rb").read())
print(f"built {os.path.relpath(zpath)}")
PY
