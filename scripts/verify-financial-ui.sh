#!/usr/bin/env bash
# Quick anti-pattern check for financial UIs.
# Usage: ./scripts/verify-financial-ui.sh <path-to-src>
# Example: ./scripts/verify-financial-ui.sh ../my-app/src
#
# Catches the cheap stuff. Not a substitute for the agent reading the SKILL.
# Exit 0 if clean, 1 if any anti-pattern matched.

set -u
ROOT="${1:-.}"
FAIL=0

scan() {
  local label="$1"
  local pattern="$2"
  local count
  count=$(rg --no-heading --color=never -tjsx -ttsx -tts -tjs -tcss "$pattern" "$ROOT" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -gt 0 ]; then
    echo "❌ [$count] $label"
    rg --no-heading --color=never -tjsx -ttsx -tts -tjs -tcss "$pattern" "$ROOT" 2>/dev/null | head -5
    echo
    FAIL=1
  else
    echo "✅ $label"
  fi
}

echo "Scanning $ROOT"
echo

scan "Raw green colors (use text-positive)"  'text-(green|emerald|lime)-[0-9]+'
scan "Raw red colors (use text-negative)"    'text-(red|rose)-[0-9]+'
scan "Raw zinc/slate surfaces (use bg-surface)" 'bg-(zinc|slate|neutral|gray)-[0-9]+'
scan "Dynamic Tailwind classes (JIT strips)" 'bg-\$\{[^}]+\}|text-\$\{[^}]+\}|border-\$\{[^}]+\}'
scan "toFixed(2) on prices (use magnitude-aware fmt)" '\.toFixed\(2\)'
scan "Centered numbers in tables"            'text-center.*tabular-nums|tabular-nums.*text-center'
scan "Hardcoded hex colors in components"    '#[0-9a-fA-F]{3,8}\b'
scan "console.log in production code"        'console\.log\('

echo
if [ "$FAIL" -eq 0 ]; then
  echo "✅ No common anti-patterns found."
else
  echo "❌ Anti-patterns found. See above."
  exit 1
fi
