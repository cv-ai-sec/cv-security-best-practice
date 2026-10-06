# Git workflow best practices

A command reference for git, with the security check that goes with each step. The checks matter most before a push,
because a push to a remote makes a secret public or shared.

## Getting and creating repositories

| Command | What it does |
|---|---|
| `git init -b main` | Start a repository on the `main` branch |
| `git clone <url>` | Copy an existing remote repository locally |
| `git remote add origin <url>` | Point a local repository at a remote |
| `git remote -v` | List remotes. **Check for credentials in the URL** (see below) |

**Security:** a remote URL with a password or token in it (`https://user:token@host/...`) stores the credential in
`.git/config`. Use a credential helper or a platform sign-in instead, and never put a token in a URL.

## Snapshotting

| Command | What it does |
|---|---|
| `git status` | Show staged, unstaged, and untracked changes. Run before every `add` |
| `git add <file> ...` | Stage named files. Prefer this to `git add -A` or `git add .` |
| `git diff --cached --stat` | Summarize what is staged |
| `git commit -m "<message>"` | Record staged changes |
| `git restore --staged <file>` | Unstage a file without losing its changes |

**Security:** a broad `git add` stages everything not ignored. Name files, and read `git status` each time.

## Ignore rules

Put these in `.gitignore` before the first `git add`:

```gitignore
.env
.env.*
!.env.example
*.pem
*.key
*.log
logs/
node_modules/
dist/
.venv/
__pycache__/
```

Confirm the rule catches a file before you trust it:

```bash
git check-ignore -v .env      # should print the rule that matched
```

**Security:** `.gitignore` only stops new files from being staged. If a secret file was tracked before the rule was
added, it stays tracked until you run `git rm --cached <file>`.

## Branching and merging

| Command | What it does |
|---|---|
| `git switch -c <name>` | Create and switch to a branch |
| `git switch <name>` | Switch to an existing branch |
| `git merge <branch>` | Merge another branch into the current one |
| `git rebase origin/main` | Replay local commits on the remote's latest. Use before a first push, when there is no shared history yet |

## Sharing

| Command | What it does |
|---|---|
| `git fetch origin` | Download remote changes without merging |
| `git pull` | Fetch and merge the current branch's remote |
| `git push -u origin main` | Push and set the upstream (first push only) |
| `git push` | Push local commits |

## Inspecting what a push will send

| Command | What it does |
|---|---|
| `git log --oneline origin/main..HEAD` | Commits that exist locally but not on the remote |
| `git diff origin/main..HEAD --stat` | Files a push would change |
| `git diff origin/main..HEAD` | Full content of a push. Read it before pushing |
| `git ls-files` | Every tracked file. Confirm no secret file is listed |

## Pre-push secret check

Run this every time, to every remote, not only the first push. A secret that reaches a remote should be treated as
exposed and rotated.

**Bash:**

```bash
git status
git diff --cached --stat

# Secret-shaped strings in the staged diff. Any hit: stop and inspect the file.
git diff --cached | grep -iE "(api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY)"

# No real .env tracked (only .env.example is acceptable)
git ls-files | grep -E "^\.env$"

# Scan everything the push would send, across all unpushed commits
git diff origin/main..HEAD | grep -iE "api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY"
```

**PowerShell:**

```powershell
git status
git diff --cached --stat
git diff --cached | Select-String -Pattern "api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY" -CaseSensitive:$false
git ls-files | Select-String "^\.env$"
git diff origin/main..HEAD | Select-String -Pattern "api[_-]?key|apikey|secret|password|token|sk-[a-zA-Z0-9]|AIza|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY" -CaseSensitive:$false
```

Or run the preflight script in [scripts/](scripts/), which runs the same checks and reports a failure for each one.

**Expected hits:** placeholder values in documentation, and variable names such as `API_KEY` without a value. A real value
is a stop.

## Rewriting history (only when a secret was committed)

Rewriting history is destructive and changes every commit hash. Rotate the secret first. Then remove it from history with
a dedicated tool such as `git-filter-repo`, and force-push only after every collaborator has been told to re-clone.

## Commit hygiene

- One logical change per commit, with a message that says what changed and why.
- Keep attribution lines to what your own policy requires. Some teams strip AI trailers, and some require them.
- Read the commit before it is shared: `git show <commit>`.
