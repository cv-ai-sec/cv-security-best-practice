#!/usr/bin/env bash
#
# Pre-push secret/sanity check. Run from inside any git repo before pushing.
# See ../docs/SECRET-CHECKLIST.md for the full reasoning behind each step.
#
# Usage: bash preflight-check.sh [base-branch]
#   base-branch defaults to origin/main

set -uo pipefail

BASE="${1:-origin/main}"
problems=0

echo "==> Checking .env is not tracked..."
if git ls-files | grep -qE "^\.env$"; then
  echo "    FAIL: .env is tracked by git. Run: git rm --cached .env"
  problems=$((problems + 1))
else
  echo "    OK"
fi

echo ""
echo "==> Confirming .gitignore actually catches .env (git check-ignore -v)..."
ignore_hit=$(git check-ignore -v .env 2>/dev/null)
if [[ -n "$ignore_hit" ]]; then
  echo "    OK: $ignore_hit"
else
  echo "    WARNING: .gitignore does not appear to match .env (or .env doesn't exist here) — verify manually."
fi

echo ""
echo "==> Scanning staged diff for secret-shaped strings..."
staged_hits=$(git diff --cached 2>/dev/null | grep -niE "api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY" || true)
if [[ -n "$staged_hits" ]]; then
  echo "    Found potential matches in staged changes — review manually:"
  echo "$staged_hits" | sed 's/^/    /'
else
  echo "    No matches found."
fi

echo ""
echo "==> Scanning diff against ${BASE} for secret-shaped strings..."
hits=$(git diff "${BASE}..HEAD" 2>/dev/null | grep -niE "api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY" || true)
if [[ -n "$hits" ]]; then
  echo "    Found potential matches — review each one manually (placeholders are fine, real values are not):"
  echo "$hits" | sed 's/^/    /'
else
  echo "    No matches found."
fi

echo ""
echo "==> Files that would be pushed:"
git diff "${BASE}..HEAD" --stat 2>/dev/null || echo "    (no upstream tracking yet — run 'git log' instead)"

echo ""
echo "==> Commits that would be pushed:"
git log --oneline "${BASE}..HEAD" 2>/dev/null || git log --oneline

echo ""
if [[ $problems -gt 0 ]]; then
  echo "==> $problems blocking problem(s) found. Fix before pushing."
  exit 1
else
  echo "==> No blocking problems found. Review the diff/commit list above, then push yourself."
fi
