#!/usr/bin/env bash
# Validate every manifest and skill in this repo, offline, with python3 only.
# Checks: JSON syntax, one shared plugin version, each target's schema rules and limits,
# skill frontmatter (Agent Skills spec + Claude.ai upload limits), skill lists, asset paths,
# and banned wording. When `claude` or `clawhub` is on PATH it also runs their validators.
#
# Usage: ./scripts/check.sh            exit 1 on any error
#        SKIP_TOOLS=1 ./scripts/check.sh  skip the claude / clawhub CLI validators
set -euo pipefail
cd "$(dirname "$0")/.."

python3 -I - <<'PY'
import json, os, re, struct, sys

errors, warnings = [], []
def err(msg): errors.append(msg)
def warn(msg): warnings.append(msg)

def load(path):
    try:
        with open(path, encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        err(f"{path}: missing"); return None
    except json.JSONDecodeError as e:
        err(f"{path}: invalid JSON ({e})"); return None

def https(url, where):
    if not isinstance(url, str) or not url.startswith("https://"):
        err(f"{where}: must be an https:// URL, got {url!r}")

def exists(rel, where):
    p = rel[2:] if rel.startswith("./") else rel
    if not os.path.exists(p):
        err(f"{where}: path {rel!r} does not exist")
    return p

def png_size(path):
    with open(path, "rb") as f:
        head = f.read(24)
    if head[:8] != b"\x89PNG\r\n\x1a\n":
        return None
    return struct.unpack(">II", head[16:24])

SKILLS = sorted(d for d in os.listdir("skills") if os.path.isfile(f"skills/{d}/SKILL.md"))
for d in os.listdir("skills"):
    if os.path.isdir(f"skills/{d}") and d not in SKILLS:
        err(f"skills/{d}: no SKILL.md")

M = {p: load(p) for p in [
    ".claude-plugin/plugin.json", ".claude-plugin/marketplace.json", ".codex-plugin/plugin.json",
    ".cursor-plugin/plugin.json", ".grok-plugin/plugin.json", ".agents/plugins/marketplace.json",
    "gemini-extension.json", "openclaw.plugin.json", "package.json", "plugin.json", "mcp.json", ".mcp.json",
]}
if any(v is None for v in M.values()):
    print("\n".join("ERROR " + e for e in errors)); sys.exit(1)

# ---- one name, one version everywhere ------------------------------------------------------
versions = {
    ".claude-plugin/plugin.json": M[".claude-plugin/plugin.json"].get("version"),
    ".claude-plugin/marketplace.json plugins[0]": M[".claude-plugin/marketplace.json"]["plugins"][0].get("version"),
    ".codex-plugin/plugin.json": M[".codex-plugin/plugin.json"].get("version"),
    ".cursor-plugin/plugin.json": M[".cursor-plugin/plugin.json"].get("version"),
    ".grok-plugin/plugin.json": M[".grok-plugin/plugin.json"].get("version"),
    "gemini-extension.json": M["gemini-extension.json"].get("version"),
    "openclaw.plugin.json": M["openclaw.plugin.json"].get("version"),
    "package.json": M["package.json"].get("version"),
    "plugin.json": M["plugin.json"].get("version"),
}
if len(set(versions.values())) != 1:
    err("versions differ: " + ", ".join(f"{k}={v}" for k, v in versions.items()))
VERSION = versions["plugin.json"]
if not re.fullmatch(r"\d+\.\d+\.\d+", str(VERSION)):
    err(f"plugin version {VERSION!r} is not semver x.y.z")
names = {p: M[p].get("name") for p in [".claude-plugin/plugin.json", ".codex-plugin/plugin.json",
         ".cursor-plugin/plugin.json", ".grok-plugin/plugin.json", "gemini-extension.json", "package.json", "plugin.json"]}
names["openclaw.plugin.json id"] = M["openclaw.plugin.json"].get("id")
names["claude marketplace entry"] = M[".claude-plugin/marketplace.json"]["plugins"][0].get("name")
names["codex marketplace entry"] = M[".agents/plugins/marketplace.json"]["plugins"][0].get("name")
if set(names.values()) != {"orshot"}:
    err("plugin names differ: " + ", ".join(f"{k}={v}" for k, v in names.items()))

# ---- Claude Code plugin + marketplace -------------------------------------------------------
cp = M[".claude-plugin/plugin.json"]
for k in ("description", "author", "homepage", "repository", "license"):
    if not cp.get(k): err(f".claude-plugin/plugin.json: {k} missing")
for k in ("documentationUrl", "supportUrl", "privacyPolicyUrl", "termsOfServiceUrl", "homepage"):
    https(cp.get(k), f".claude-plugin/plugin.json {k}")
if "icon" in cp:
    exists(cp["icon"], ".claude-plugin/plugin.json icon")
mk = M[".claude-plugin/marketplace.json"]
entry = mk["plugins"][0]
listed = sorted(s.removeprefix("./skills/").rstrip("/") for s in entry.get("skills", []))
if entry.get("skills") and listed != SKILLS:
    err(f".claude-plugin/marketplace.json skills {listed} != skills/ {SKILLS}")
for k in ("icon", "documentationUrl", "supportUrl", "privacyPolicyUrl", "termsOfServiceUrl"):
    if k in entry: err(f".claude-plugin/marketplace.json: {k} belongs in plugin.json only")

# ---- MCP configs ----------------------------------------------------------------------------
for name, s in M[".mcp.json"].get("mcpServers", {}).items():
    if s.get("type") not in ("http", "sse", "ws"):
        err(f".mcp.json {name}: type must be http, sse or ws for a remote server")
    https(s.get("url"), f".mcp.json {name} url")
    extra = set(s) - {"type", "url", "headers", "headersHelper", "oauth"}
    if extra: err(f".mcp.json {name}: unexpected keys {sorted(extra)}")
    if s.get("headers"): err(f".mcp.json {name}: no fixed headers (directories reject credentials in headers)")

ap_mcp = M["mcp.json"]
if ap_mcp.get("$schema") != "https://agent-plugins.org/schemas/1.0.0/mcp.schema.json":
    err("mcp.json: $schema must be the Agent Plugins 1.0.0 MCP schema")
if set(ap_mcp) - {"$schema", "mcpServers"}:
    err(f"mcp.json: only $schema and mcpServers allowed, got {sorted(ap_mcp)}")
for name, s in ap_mcp.get("mcpServers", {}).items():
    if s.get("type") not in ("streamable-http", "sse", "stdio"):
        err(f"mcp.json {name}: type must be streamable-http, sse or stdio")
    if s.get("type") in ("streamable-http", "sse"):
        https(s.get("url"), f"mcp.json {name} url")
        if set(s) - {"type", "url", "headers"}:
            err(f"mcp.json {name}: closed schema allows only type, url, headers; got {sorted(s)}")

urls = {s.get("url") for s in M[".mcp.json"]["mcpServers"].values()} | \
       {s.get("url") for s in ap_mcp["mcpServers"].values()} | \
       {s.get("httpUrl") or s.get("url") for s in M["gemini-extension.json"].get("mcpServers", {}).values()} | \
       {s.get("url") for s in M["openclaw.plugin.json"].get("mcpServers", {}).values()}
if len(urls) != 1:
    err(f"MCP server URLs differ across manifests: {sorted(map(str, urls))}")

# ---- Agent Plugins root manifest (agent-plugins.org 1.0.0) -----------------------------------
ap = M["plugin.json"]
if ap.get("$schema") != "https://agent-plugins.org/schemas/1.0.0/plugin.schema.json":
    err("plugin.json: $schema must be the Agent Plugins 1.0.0 plugin schema")
allowed = {"$schema", "name", "version", "description", "author", "homepage", "repository", "license", "keywords", "extensions"}
if set(ap) - allowed: err(f"plugin.json: unknown top-level keys {sorted(set(ap) - allowed)}")
if not re.fullmatch(r"(?!.*(?:--|\.\.))[a-z0-9](?:[a-z0-9.-]*[a-z0-9])?", ap.get("name", "")) or len(ap["name"]) > 64:
    err("plugin.json: name does not match the Agent Plugins pattern")
if set(ap.get("author", {})) - {"name", "email", "url"}: err("plugin.json: author allows name, email, url only")
for k, v in ap.get("extensions", {}).items():
    if not isinstance(v, dict): err(f"plugin.json: extensions.{k} must be an object")

# ---- OpenAI / Codex listing (submission limits) ----------------------------------------------
def check_interface(i, where):
    lim = {"displayName": 30, "shortDescription": 30, "longDescription": 4000, "developerName": 80}
    for k, n in lim.items():
        v = i.get(k)
        if not v: err(f"{where}: interface.{k} required")
        elif len(v) > n: err(f"{where}: interface.{k} is {len(v)} chars, max {n}")
    if not i.get("category"): err(f"{where}: interface.category required")
    caps = i.get("capabilities")
    if not isinstance(caps, list) or len(caps) > 20: err(f"{where}: interface.capabilities must be a list of up to 20")
    for k in ("websiteURL", "supportURL", "privacyPolicyURL", "termsOfServiceURL"):
        https(i.get(k), f"{where} interface.{k}")
    dp = i.get("defaultPrompt", [])
    if len(dp) > 3: err(f"{where}: interface.defaultPrompt has {len(dp)} prompts, max 3")
    if len(set(dp)) != len(dp): err(f"{where}: interface.defaultPrompt must be unique")
    for p in dp:
        if len(p) > 128: err(f"{where}: defaultPrompt over 128 chars: {p[:40]}...")
    if not re.fullmatch(r"#[0-9A-Fa-f]{6}", i.get("brandColor", "")): err(f"{where}: brandColor must be #RRGGBB")
    for k in ("composerIcon", "logo"):
        v = i.get(k)
        if not v or not v.startswith("./"): err(f"{where}: interface.{k} must be a ./ path"); continue
        p = exists(v, f"{where} interface.{k}")
        if os.path.exists(p):
            size = png_size(p)
            if not size: err(f"{where}: {v} is not a PNG")
            elif size[0] != size[1] or size[0] < 48 or size[0] > 4096: err(f"{where}: {v} must be square, 48 to 4096 px, got {size}")
            if os.path.getsize(p) > 5 * 1024 * 1024: err(f"{where}: {v} over 5 MiB")

cx = M[".codex-plugin/plugin.json"]
check_interface(cx.get("interface", {}), ".codex-plugin/plugin.json")
root_iface = ap.get("extensions", {}).get("com.openai", {}).get("interface")
if root_iface is None:
    warn("plugin.json: no extensions.com.openai.interface; OpenAI falls back to .codex-plugin/plugin.json")
else:
    check_interface(root_iface, "plugin.json extensions.com.openai")
    if root_iface != cx.get("interface"):
        err("plugin.json extensions.com.openai.interface and .codex-plugin/plugin.json interface differ (OpenAI reads the root one)")
if len(ap.get("description", "")) > 4000: err("plugin.json: description over 4000 chars")
if not (ap.get("author") or {}).get("name"): err("plugin.json: author.name required by OpenAI")
for k in ("skills", "mcpServers"):
    if k in cx: exists(cx[k], f".codex-plugin/plugin.json {k}")
cm = M[".agents/plugins/marketplace.json"]["plugins"][0]
if not cm.get("policy", {}).get("installation") or not cm.get("policy", {}).get("authentication") or not cm.get("category"):
    err(".agents/plugins/marketplace.json: each entry needs policy.installation, policy.authentication and category")

# ---- Cursor (cursor/plugins schemas/plugin.schema.json) ----------------------------------------
cu = M[".cursor-plugin/plugin.json"]
allowed = {"name", "displayName", "description", "version", "minClientVersions", "author", "publisher", "homepage",
           "repository", "license", "logo", "keywords", "category", "tags", "commands", "agents", "skills", "rules",
           "hooks", "variables", "mcpServers"}
if set(cu) - allowed: err(f".cursor-plugin/plugin.json: keys not in Cursor's closed schema {sorted(set(cu) - allowed)}")
if set(cu.get("author", {})) - {"name", "email"}: err(".cursor-plugin/plugin.json: author allows name and email only")
if not re.fullmatch(r"[a-z0-9]([a-z0-9.-]*[a-z0-9])?", cu.get("name", "")): err(".cursor-plugin/plugin.json: bad name")
for k in ("logo", "mcpServers", "skills"):
    if isinstance(cu.get(k), str) and not cu[k].startswith("http"): exists(cu[k], f".cursor-plugin/plugin.json {k}")

# ---- Grok, Gemini, OpenClaw, ClawHub package -----------------------------------------------------
gr = M[".grok-plugin/plugin.json"]
if not gr.get("description") or not gr.get("homepage"): err(".grok-plugin/plugin.json: description and homepage required")
ge = M["gemini-extension.json"]
if not re.fullmatch(r"[a-z0-9-]+", ge.get("name", "")): err("gemini-extension.json: name must be lowercase with dashes")
if ge.get("contextFileName"): exists(ge["contextFileName"], "gemini-extension.json contextFileName")
for name, s in ge.get("mcpServers", {}).items():
    if "trust" in s: err(f"gemini-extension.json {name}: trust is not allowed in extensions")
oc = M["openclaw.plugin.json"]
if "configSchema" not in oc: err("openclaw.plugin.json: configSchema required")
cats = oc.get("categories", [])
if len(cats) > 1: err("openclaw.plugin.json: ClawHub accepts exactly one category for new releases")
if sorted(s.removeprefix("skills/") for s in oc.get("skills", [])) != SKILLS:
    err(f"openclaw.plugin.json skills != skills/ {SKILLS}")
for name, s in oc.get("mcpServers", {}).items():
    if s.get("transport") not in ("streamable-http", "sse", "stdio"): err(f"openclaw.plugin.json {name}: transport")
if not os.path.exists("assets/icon.png") or os.path.getsize("assets/icon.png") > 512 * 1024:
    err("assets/icon.png: ClawHub catalog icon missing or over 512 KiB")

# ---- Skills: Agent Skills spec, Claude.ai upload limits, ClawHub versions ------------------------
for slug in SKILLS:
    path = f"skills/{slug}/SKILL.md"
    text = open(path, encoding="utf-8").read()
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m: err(f"{path}: no YAML frontmatter"); continue
    fm = m.group(1)
    def field(key):
        f = re.search(rf"^{key}:\s*(.*)$", fm, re.M)
        if not f: return None
        v = f.group(1).strip()
        if v.startswith('"'):
            try: return json.loads(v)
            except json.JSONDecodeError: err(f"{path}: {key} is not a valid double-quoted string"); return v
        return v.strip("'")
    name, desc = field("name"), field("description")
    if name != slug: err(f"{path}: name {name!r} != folder {slug!r}")
    if not name or len(name) > 64 or not re.fullmatch(r"[a-z0-9]+(-[a-z0-9]+)*", name):
        err(f"{path}: name must be 1-64 lowercase letters, digits and single hyphens")
    if not desc: err(f"{path}: description missing")
    elif len(desc) > 1024: err(f"{path}: description is {len(desc)} chars, max 1024 (Claude.ai, Agent Skills spec)")
    elif re.search(r"[<>]", desc): err(f"{path}: description must not contain < or >")
    if not re.search(r'^  version: "\d+\.\d+\.\d+"$', fm, re.M):
        err(f"{path}: metadata.version \"x.y.z\" missing (scripts/publish.sh reads it)")
    extra = [k for k in re.findall(r"^([A-Za-z0-9_-]+):", fm, re.M)
             if k not in {"name", "description", "license", "compatibility", "metadata", "allowed-tools"}]
    if extra:
        warn(f"{path}: frontmatter keys outside the Agent Skills spec {extra} (scripts/build-dist.sh drops them from the Claude.ai zip)")
    lines = text.count("\n")
    if lines > 500: warn(f"{path}: {lines} lines, Claude recommends under 500")
    for ref in sorted(set(re.findall(r"references/[A-Za-z0-9_./-]+", text))):
        ref = ref.rstrip(".")
        if os.path.exists(f"skills/{slug}/{ref}"):
            continue
        owners = [s for s in SKILLS if os.path.exists(f"skills/{s}/{ref}")]
        if owners:
            warn(f"{path}: points to {ref} in skill {owners[0]}; a standalone Claude.ai zip of {slug} will not carry it")
        else:
            err(f"{path}: links {ref} which does not exist in any skill")

# ---- Files the Claude directory and ClawHub scanners care about ------------------------------------
for dirpath, dirnames, filenames in os.walk("."):
    dirnames[:] = [d for d in dirnames if d not in (".git", "dist", "node_modules", "reports")]
    for f in filenames:
        p = os.path.join(dirpath, f)
        if f in (".DS_Store", "Thumbs.db", "desktop.ini"):
            err(f"{p}: system file in the plugin folder (Claude directory blocks it)")
        elif not f.endswith((".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg")) and os.path.getsize(p) > 256 * 1024:
            warn(f"{p}: over 256 KiB, held for review by the Claude directory")

# ---- Wording rules (positioning lock, copy rules) -------------------------------------------------
# ---- directory builds: omit markers balanced, directory sources present ------------------------
for slug in SKILLS:
    for dirpath, _, files in os.walk(f"skills/{slug}"):
        for fn in files:
            if fn.endswith(".md"):
                fp = os.path.join(dirpath, fn); txt = open(fp, encoding="utf-8").read()
                if txt.count("<!-- directory-omit -->") != txt.count("<!-- /directory-omit -->"):
                    err(f"{fp}: unbalanced directory-omit markers")
for p in ("directory/chatgpt/plugin.json", "directory/claude/README.md"):
    if not os.path.isfile(p):
        err(f"{p}: missing (scripts/build-dist.sh reads it)")
if os.path.isfile("directory/claude/README.md") and len(open("directory/claude/README.md").read().split()) < 40:
    err("directory/claude/README.md: the Claude directory needs at least 40 words")

banned = [("—", "em dash"), ("creative automation platform", None), ("agent-first", None), ("visual content", None)]
for p in [*M.keys(), "README.md"]:
    t = open(p, encoding="utf-8").read().lower()
    for needle, label in banned:
        if needle in t: err(f"{p}: contains {label or repr(needle)}")

for w in warnings: print("warn  " + w)
for e in errors: print("ERROR " + e)
print(f"\n{len(SKILLS)} skills, plugin version {VERSION}: {len(errors)} errors, {len(warnings)} warnings")
sys.exit(1 if errors else 0)
PY

if [[ -z "${SKIP_TOOLS:-}" ]]; then
  if command -v claude >/dev/null 2>&1; then
    echo; echo "claude plugin validate --strict (marketplace, then plugin with the directory profile)"
    claude plugin validate --strict . >/dev/null
    claude plugin validate --strict --profile directory .claude-plugin/plugin.json | tail -1
    if [[ -d plugins/orshot ]]; then
      echo "claude plugin validate --strict --profile directory plugins/orshot (the directory submission)"
      claude plugin validate --strict --profile directory plugins/orshot | tail -1
      grep -rq "mcp.orshot.com/full" plugins/orshot && { echo "ERROR plugins/orshot mentions /full; rebuild"; exit 1; } || true
    fi
  fi
  if command -v clawhub >/dev/null 2>&1; then
    echo; echo "clawhub package validate"
    clawhub package validate . --out "${TMPDIR:-/tmp}/orshot-plugin-reports" | head -4
  fi
fi
