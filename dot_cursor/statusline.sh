#!/usr/bin/env bash
# Cursor Agent CLI statusLine command

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Agent"')
PARAM=$(echo "$input" | jq -r '.model.param_summary // empty')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
WORKTREE=$(echo "$input" | jq -r '.worktree.name // empty')

LABEL="$MODEL"
[ -n "$PARAM" ] && LABEL="$LABEL $PARAM"
[ "$(echo "$input" | jq -r '.model.max_mode // false')" = "true" ] && LABEL="$LABEL Max"

BRANCH=""
if [ -n "$DIR" ] && git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
  [ -n "$BRANCH" ] && BRANCH=" 🌿 $BRANCH"
fi

WT=""
[ -n "$WORKTREE" ] && WT=" [wt:$WORKTREE]"

DIRNAME="${DIR##*/}"

BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && printf -v FILL "%${FILLED}s" && BAR="${FILL// /▓}"
[ "$EMPTY" -gt 0 ] && printf -v PAD "%${EMPTY}s" && BAR="${BAR}${PAD// /░}"

printf '\033[36m[%s]\033[0m 📁 %s%s%s\n' "$LABEL" "$DIRNAME" "$BRANCH" "$WT"
printf '\033[90mctx %s %s%%\033[0m\n' "$BAR" "$PCT"
