#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  scripts/new-kb.sh "<slug>" "<Title>" "<one-line description>"

Example:
  scripts/new-kb.sh "docker-openclaw" "Docker OpenClaw Setup" "Run OpenClaw with Docker Compose"
USAGE
}

if [[ $# -ne 3 ]]; then
  usage
  exit 1
fi

slug="$1"
title="$2"
description="$3"

if [[ ! "$slug" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "Error: slug must use lowercase letters, numbers, and hyphens only." >&2
  exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
root_readme="$repo_root/README.md"
topic_dir="$repo_root/$slug"
topic_readme="$topic_dir/README.md"

if [[ ! -f "$root_readme" ]]; then
  echo "Error: root README.md not found at $root_readme" >&2
  exit 1
fi

if [[ -e "$topic_dir" ]]; then
  echo "Error: topic directory already exists: $topic_dir" >&2
  exit 1
fi

if grep -Fq "(./$slug/README.md)" "$root_readme"; then
  echo "Error: KB index already contains ./$slug/README.md" >&2
  exit 1
fi

if ! grep -Eq '^## .*KB[[:space:]]+Index.*$' "$root_readme"; then
  echo "Error: root README.md is missing a KB Index section." >&2
  exit 1
fi

next_number="$(awk '
  BEGIN { in_index = 0; count = 0 }
  /^## .*KB[[:space:]]+Index.*$/ { in_index = 1; next }
  /^## / {
    if (in_index == 1) {
      in_index = 0
    }
  }
  {
    if (in_index == 1 && $0 ~ /^[0-9]+\.[[:space:]]+\[/) {
      count++
    }
  }
  END { print count + 1 }
' "$root_readme")"

mkdir -p "$topic_dir"

cat > "$topic_readme" <<TOPIC_TEMPLATE
# **$title**

$description

## 🧭 **Overview**

Add context for this KB topic.

## ✅ **Prerequisites**

- Add required tools, services, or environment details.

## ⚙️ **Steps**

1. Add step-by-step instructions.
2. Add verification checks.

## 📎 **Useful Commands**

\`\`\`bash
# Add commands that operators can copy/paste
\`\`\`

## 🛠️ **Troubleshooting**

- Add known issues and fixes.
TOPIC_TEMPLATE

new_entry="$next_number. [$title](./$slug/README.md) - $description"
tmp_file="$(mktemp)"

awk -v new_entry="$new_entry" '
  BEGIN { in_index = 0; inserted = 0; seen_index = 0 }

  /^## .*KB[[:space:]]+Index.*$/ {
    seen_index = 1
    in_index = 1
    print
    next
  }

  /^## / {
    if (in_index == 1 && inserted == 0) {
      print new_entry
      inserted = 1
    }
    in_index = 0
  }

  {
    print
  }

  END {
    if (seen_index == 0) {
      exit 2
    }

    if (in_index == 1 && inserted == 0) {
      print new_entry
    }
  }
' "$root_readme" > "$tmp_file"

mv "$tmp_file" "$root_readme"

echo "Created: $topic_readme"
echo "Updated: $root_readme"
