#!/bin/zsh
set -euo pipefail

repo_dir="/Users/maulanabayu/Documents/01 Projects/daily-logs"
cd "$repo_dir"

today="$(date +%Y-%m-%d)"
now="$(date '+%H:%M:%S %Z')"
note_file="notes/${today}.md"

mkdir -p notes

if [[ ! -f "$note_file" ]]; then
  {
    printf '## %s\n\n' "$today"
  } > "$note_file"
fi

printf -- '- Daily check-in at %s\n' "$now" >> "$note_file"

git add notes "$0"

if git diff --cached --quiet; then
  exit 0
fi

git commit -m "chore: daily update ${today}"
git push origin main
