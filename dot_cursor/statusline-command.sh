#!/usr/bin/env bash
# Cursor Agent CLI statusLine command (same as Claude Code)

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

dir_display="${cwd##*/}"

git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir --no-optional-locks > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD --no-optional-locks 2>/dev/null || git -C "$cwd" rev-parse --short HEAD --no-optional-locks 2>/dev/null)
fi

output=""

output+="$(printf '\033[36m%s\033[0m' "$dir_display")"

if [ -n "$git_branch" ]; then
  output+=" $(printf '\033[35m %s\033[0m' "$git_branch")"
fi

output+=" $(printf '\033[90m|\033[0m')"

if [ -n "$model" ]; then
  output+=" $(printf '\033[34m%s\033[0m' "$model")"
fi

if [ -n "$used_pct" ]; then
  used_int=${used_pct%.*}
  if [ "${used_int:-0}" -ge 70 ] 2>/dev/null; then
    ctx_color='\033[33m'
  else
    ctx_color='\033[32m'
  fi
  output+=" $(printf "${ctx_color}ctx:%s%%\033[0m" "$used_pct")"
fi

printf '%s' "$output"
