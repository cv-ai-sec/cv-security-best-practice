# Pre-push secret/sanity check. Run from inside any git repo before pushing.
# See ../docs/SECRET-CHECKLIST.md for the full reasoning behind each step.
#
# Usage: .\preflight-check.ps1 [-Base origin/main]

param(
    [string]$Base = "origin/main"
)

$problems = 0
$pattern = "api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY"

Write-Host "==> Checking .env is not tracked..."
$trackedEnv = git ls-files | Select-String -Pattern "^\.env$"
if ($trackedEnv) {
    Write-Host "    FAIL: .env is tracked by git. Run: git rm --cached .env" -ForegroundColor Red
    $problems++
} else {
    Write-Host "    OK" -ForegroundColor Green
}

Write-Host ""
Write-Host "==> Confirming .gitignore actually catches .env (git check-ignore -v)..."
$ignoreHit = git check-ignore -v .env 2>$null
if ($ignoreHit) {
    Write-Host "    OK: $ignoreHit" -ForegroundColor Green
} else {
    Write-Host "    WARNING: .gitignore does not appear to match .env (or .env doesn't exist here) - verify manually." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "==> Scanning staged diff for secret-shaped strings..."
$stagedDiff = git diff --cached 2>$null
$stagedHits = $stagedDiff | Select-String -Pattern $pattern -CaseSensitive:$false
if ($stagedHits) {
    Write-Host "    Found potential matches in staged changes - review manually:" -ForegroundColor Yellow
    $stagedHits | ForEach-Object { Write-Host "    $_" }
} else {
    Write-Host "    No matches found." -ForegroundColor Green
}

Write-Host ""
Write-Host "==> Scanning diff against $Base for secret-shaped strings..."
$diff = git diff "$Base..HEAD" 2>$null
$hits = $diff | Select-String -Pattern $pattern -CaseSensitive:$false
if ($hits) {
    Write-Host "    Found potential matches - review each one manually (placeholders are fine, real values are not):" -ForegroundColor Yellow
    $hits | ForEach-Object { Write-Host "    $_" }
} else {
    Write-Host "    No matches found." -ForegroundColor Green
}

Write-Host ""
Write-Host "==> Files that would be pushed:"
try {
    git diff "$Base..HEAD" --stat
} catch {
    Write-Host "    (no upstream tracking yet - run 'git log' instead)"
}

Write-Host ""
Write-Host "==> Commits that would be pushed:"
try {
    git log --oneline "$Base..HEAD"
} catch {
    git log --oneline
}

Write-Host ""
if ($problems -gt 0) {
    Write-Host "==> $problems blocking problem(s) found. Fix before pushing." -ForegroundColor Red
    exit 1
} else {
    Write-Host "==> No blocking problems found. Review the diff/commit list above, then push yourself." -ForegroundColor Green
}
