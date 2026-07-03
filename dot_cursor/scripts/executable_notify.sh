#!/bin/bash
message="${1:-通知}"
client_tty=$(tmux display-message -p '#{client_tty}' 2>/dev/null)
if [ -n "$client_tty" ] && [ -w "$client_tty" ]; then
  printf '\033]9;%s\033\\' "$message" > "$client_tty"
fi
