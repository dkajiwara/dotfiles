#!/usr/bin/env bash
# Claude Code statusLine command
# Inspired by Starship prompt configuration

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Directory display (basename only)
dir_display="${cwd##*/}"

# Git branch (skip optional lock to avoid interference)
git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd/.git" ] || git -C "$cwd" rev-parse --git-dir --no-optional-locks > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" symbolic-ref --short HEAD --no-optional-locks 2>/dev/null || git -C "$cwd" rev-parse --short HEAD --no-optional-locks 2>/dev/null)
fi

# Build status line with ANSI colors (will render dimmed in Claude Code)
output=""

# Directory part (cyan)
output+="$(printf '\033[36m%s\033[0m' "$dir_display")"

# Git branch (magenta)
if [ -n "$git_branch" ]; then
  output+=" $(printf '\033[35m %s\033[0m' "$git_branch")"
fi

# Separator
output+=" $(printf '\033[90m|\033[0m')"

# Model (blue)
if [ -n "$model" ]; then
  output+=" $(printf '\033[34m%s\033[0m' "$model")"
fi

# Context usage (yellow if >= 70%, green otherwise)
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
