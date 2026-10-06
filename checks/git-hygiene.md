# Git hygiene checks

Checks for what should and shouldn't reach a git repository. The agent reads these files; the user runs the git commands
(see [operating-model.md](operating-model.md)).

## 1. `.gitignore` completeness

- **Detect:** no `.gitignore`, or it lacks entries for `.env`, `.env.*`, key files (`*.pem`, `*.key`), logs, dependency
  folders (`node_modules/`, `.venv/`), and build output (`dist/`).
- **Explain:** anything not ignored can be staged by a broad `git add`. Ignore rules are the cheapest guard.
- **Fix:** add the missing entries. Keep `!.env.example` so the example file stays tracked.

## 2. `.env` not tracked

- **Detect:** the user's file list includes `.env` or `.env.<name>` (other than `.env.example`).
- **Explain:** a committed `.env` puts its values in every clone and in history.
- **Fix:** add it to `.gitignore`, remove it from the index (the user runs `git rm --cached`), then treat every value in
  it as exposed. Go to [leaked-secret.md](../playbooks/leaked-secret.md).

## 3. `.env.example` exists and holds placeholders

- **Detect:** a project that reads environment variables has no `.env.example`, or the example holds real-looking values.
- **Explain:** the example documents the variables without exposing values.
- **Fix:** create the example with placeholders such as `<your-token>`. Never copy real values into it.

## 4. Pre-commit secret scanning

- **Detect:** no pre-commit hook or CI step that scans staged files for secrets.
- **Explain:** a scan before each commit catches secrets before they reach history.
- **Fix:** propose a pre-commit hook that runs a dedicated scanner such as gitleaks. Show the config as a level 2 diff
  first.

## 5. Backup and dump files

- **Detect:** tracked files with names like `*.bak`, `*.sql`, `*.dump`, `*.old`, or `*~`.
- **Explain:** backups often copy a live configuration or database, with its secrets.
- **Fix:** ignore the patterns and remove the files from the index. Review the content first.

## 6. Source maps in production builds

- **Detect:** the production build config emits source maps (`*.map`) to a public folder.
- **Explain:** source maps reveal original source code, comments, and sometimes embedded configuration.
- **Fix:** disable source maps for production, or restrict them to the error-reporting service.

## 7. Git history scan

- **Detect:** the user runs a history scanner over all commits, not only the current tree. Report any match.
- **Explain:** deleting a secret from the working tree doesn't remove it from history. Anyone who cloned the repo still
  has it.
- **Fix:** treat the secret as exposed and follow [leaked-secret.md](../playbooks/leaked-secret.md). Don't just delete
  the line and commit.

## Public repositories

For a public repository, run check 7 before the first push. It covers every commit, not just the files that would be
pushed.
