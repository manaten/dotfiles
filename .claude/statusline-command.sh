#!/bin/sh
# Claude Code status line script
# Displays: model name | context usage % | token usage

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')

# Build status parts
parts=""

# Model name
parts="$model"

# Context usage percentage (only when available)
if [ -n "$used_pct" ]; then
  ctx=$(printf "%.0f" "$used_pct")
  parts="$parts | Context: ${ctx}%"
fi

# Token usage (only when available)
if [ -n "$total_input" ] && [ -n "$total_output" ]; then
  parts="$parts | Tokens in:${total_input} out:${total_output}"
fi

printf "%s" "$parts"
