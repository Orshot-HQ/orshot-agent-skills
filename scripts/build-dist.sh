#!/usr/bin/env bash
# Build upload packages into dist/ (gitignored). Nothing is uploaded or published.
#
#   dist/claude-skills/<skill>.zip   One zip per skill for Claude.ai / Claude Desktop
#                                    (Customize > Skills > Upload). Each zip holds <skill>/SKILL.md
#                                    plus its references. Frontmatter keys outside the Agent Skills
#                                    spec (name, description, license, compatibility, metadata,
#                                    allowed-tools) are dropped from the zipped copy only, because
#                                    the uploader and skills-ref reject unknown keys. Sources stay as they are.
#   dist/claude-directory/orshot/    The Claude plugin directory package (claude.ai/directory/manage), as a
#                                    folder and a zip: .claude-plugin/plugin.json, .mcp.json on /mcp,
#                                    directory skills, README.md from directory/claude/, LICENSE, icon.
#   plugins/orshot/                  The same Claude directory package, committed: the directory submission
#                                    points at this folder (Plugin path). Generated; never edit by hand.
#   dist/chatgpt/orshot-chatgpt-<v>.zip  The ChatGPT app package for the OpenAI plugin portal (existing app):
#                                    .codex-plugin/plugin.json from directory/chatgpt/plugin.json, url-only
#                                    .mcp.json on /mcp, directory skills, assets.
#   Directory skills are the same sources with /full replaced by /mcp (the directory connector),
#   <!-- directory-omit --> blocks removed (per-client install commands) and the migration page dropped.
#   The ChatGPT package also drops <!-- chatgpt-omit --> blocks (lines its skill scan flags).
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

# 2. Directory skills: the same sources, rewritten for app directories (Claude, ChatGPT).
#    The connector there is https://mcp.orshot.com/mcp, so /full becomes /mcp, the per-client
#    install commands and the migration page (competitor names) are dropped, and frontmatter is
#    sanitized as in step 1.
MCP_DIRECTORY = "https://mcp.orshot.com/mcp"
OMIT = re.compile(r"\n?<!-- directory-omit -->\n.*?<!-- /directory-omit -->\n", re.S)
DROP_FILES = {"orshot/references/migration.md"}
# <!-- chatgpt-omit --> blocks: kept everywhere except the ChatGPT package (lines its skill scan flags,
# for example a fetch from a mutable raw.githubusercontent.com branch). Other builds drop only the markers.
CG_OPEN, CG_CLOSE = "<!-- chatgpt-omit -->", "<!-- /chatgpt-omit -->"
CG_OMIT = re.compile(r"\n?<!-- chatgpt-omit -->\n.*?<!-- /chatgpt-omit -->\n", re.S)
CG_MARK = re.compile(r"^<!-- /?chatgpt-omit -->\n", re.M)


def chatgpt_variant(rel, data, chatgpt):
    if not rel.endswith(".md"):
        return data
    text = data.decode("utf-8")
    if text.count(CG_OPEN) != text.count(CG_CLOSE):
        raise SystemExit(f"skills/{rel}: unbalanced chatgpt-omit markers")
    text = CG_OMIT.sub("\n", text) if chatgpt else CG_MARK.sub("", text)
    if "chatgpt-omit" in text:
        raise SystemExit(f"skills/{rel}: chatgpt-omit marker left in the copy")
    return text.encode("utf-8")


def directory_text(text, path):
    if text.count("<!-- directory-omit -->") != text.count("<!-- /directory-omit -->"):
        raise SystemExit(f"{path}: unbalanced directory-omit markers")
    text = OMIT.sub("\n", text)
    text = text.replace("https://mcp.orshot.com/full", MCP_DIRECTORY)
    text = re.sub(r', \\"move from [^"\\]*\\"', "", text)  # trigger phrase naming a competitor
    text = re.sub(r", and the `orshot` skill's \[`references/migration\.md`\]\([^)]*\)", "", text)
    for bad in ("/full", "directory-omit", "migration.md", "openclaw mcp", "claude mcp add"):
        if bad in text:
            raise SystemExit(f"{path}: {bad!r} left in the directory copy")
    return text


def directory_skills():
    """Yield (arcname under skills/, bytes) for every directory skill file."""
    for slug in sorted(os.listdir("skills")):
        sdir = os.path.join("skills", slug)
        if not os.path.isfile(os.path.join(sdir, "SKILL.md")):
            continue
        for f in walk(sdir):
            rel = os.path.relpath(f, "skills")
            if rel in DROP_FILES:
                continue
            data = open(f, "rb").read()
            if f.endswith(".md"):
                text = directory_text(data.decode("utf-8"), f)
                if os.path.basename(f) == "SKILL.md" and os.path.dirname(rel) == slug:
                    text, _ = sanitize_frontmatter(text, f)
                data = text.encode("utf-8")
            yield rel, data


DSKILLS = list(directory_skills())
plugin = json.load(open(".claude-plugin/plugin.json"))
version = plugin["version"]

# 2a. Claude plugin directory (claude.ai/directory/manage): one clean folder plus its zip.
#     .claude-plugin/plugin.json, .mcp.json (/mcp), skills/, README.md (data-sent section), LICENSE, icon.
cdir = os.path.join(DIST, "claude-directory", "orshot")
dplugin = {**plugin, **json.load(open("directory/claude/plugin.json"))}  # directory-only overrides (description)
claude_files = {
    ".claude-plugin/plugin.json": (json.dumps(dplugin, indent=2, ensure_ascii=False) + "\n").encode(),
    ".mcp.json": (json.dumps({"mcpServers": {"orshot": {"type": "http", "url": MCP_DIRECTORY}}}, indent=2) + "\n").encode(),
    "README.md": open("directory/claude/README.md", "rb").read(),
    "LICENSE": open("LICENSE", "rb").read(),
    plugin["icon"][2:]: open(plugin["icon"][2:], "rb").read(),
}
claude_files.update({f"skills/{rel}": chatgpt_variant(rel, data, False) for rel, data in DSKILLS})
# Slash commands (/orshot:create-reel ...): Claude only. Codex and ChatGPT have no commands.
for f in sorted(os.listdir("commands")):
    if f.endswith(".md"):
        claude_files[f"commands/{f}"] = directory_text(open(os.path.join("commands", f), encoding="utf-8").read(), f"commands/{f}").encode()
zpath = os.path.join(DIST, "claude-directory", f"orshot-claude-{version}.zip")
os.makedirs(cdir)
with zipfile.ZipFile(zpath, "w") as zf:
    for rel, data in sorted(claude_files.items()):
        os.makedirs(os.path.dirname(os.path.join(cdir, rel)) or cdir, exist_ok=True)
        open(os.path.join(cdir, rel), "wb").write(data)
        add_bytes(zf, rel, data)
# The same files, committed at plugins/orshot/: the Claude directory submission reads this folder
# ("Plugin path: plugins/orshot"). Regenerated on every build, so never edit it by hand.
pdir = os.path.join(ROOT, "plugins", "orshot")
if os.path.isdir(pdir):
    shutil.rmtree(pdir)
for rel, data in sorted(claude_files.items()):
    os.makedirs(os.path.dirname(os.path.join(pdir, rel)) or pdir, exist_ok=True)
    open(os.path.join(pdir, rel), "wb").write(data)
print(f"built {os.path.relpath(cdir)}/, {os.path.relpath(zpath)} and plugins/orshot/")

# 2b. ChatGPT app package (OpenAI plugin portal, existing app). Codex layout: .codex-plugin/plugin.json
#     from directory/chatgpt/plugin.json (name, interface, review test cases, release notes), a url-only
#     .mcp.json (the portal rejects an auth override for this app), skills/ and the assets.
cg = json.load(open("directory/chatgpt/plugin.json"))
cg["skills"], cg["mcpServers"] = "./skills/", "./.mcp.json"
iface = cg["interface"]
LIMITS = {"displayName": 30, "shortDescription": 30, "longDescription": 4000}
for key, limit in LIMITS.items():
    if len(iface.get(key, "")) > limit:
        raise SystemExit(f"directory/chatgpt/plugin.json: interface.{key} is {len(iface[key])} chars, limit {limit}")
if len(iface.get("defaultPrompt", [])) > 3 or any(len(x) > 128 or "@" in x for x in iface.get("defaultPrompt", [])):
    raise SystemExit("directory/chatgpt/plugin.json: defaultPrompt is at most 3 prompts of 128 chars, no @mentions")
if len(iface.get("capabilities", [])) > 20 or any(len(x) > 120 for x in iface.get("capabilities", [])):
    raise SystemExit("directory/chatgpt/plugin.json: capabilities is at most 20 items of 120 chars")
tc = cg["extensions"]["com.openai"]["review"]["test_cases"]
if len(tc["positive"]) != 5 or len(tc["negative"]) != 3:
    raise SystemExit("directory/chatgpt/plugin.json: the portal needs exactly 5 positive and 3 negative test cases")
assets = {p[2:] for p in (iface.get("composerIcon"), iface.get("logo"), *iface.get("screenshots", [])) if p}
for a in assets:
    if not a.startswith("assets/") or not os.path.isfile(a):
        raise SystemExit(f"directory/chatgpt/plugin.json: asset {a!r} must exist under ./assets")
    if os.path.getsize(a) > 5 * 1024 * 1024:
        raise SystemExit(f"{a}: over 5 MiB")
os.makedirs(os.path.join(DIST, "chatgpt"))
zpath = os.path.join(DIST, "chatgpt", f"orshot-chatgpt-{cg['version']}.zip")
with zipfile.ZipFile(zpath, "w") as zf:
    add_bytes(zf, ".codex-plugin/plugin.json", (json.dumps(cg, indent=2, ensure_ascii=False) + "\n").encode())
    add_bytes(zf, ".mcp.json", (json.dumps({"mcpServers": {"orshot": {"url": MCP_DIRECTORY}}}) + "\n").encode())
    for a in sorted(assets):
        add_bytes(zf, a, open(a, "rb").read())
    for rel, data in DSKILLS:
        add_bytes(zf, f"skills/{rel}", chatgpt_variant(rel, data, True))
print(f"built {os.path.relpath(zpath)} ({len(DSKILLS)} skill files)")
PY
