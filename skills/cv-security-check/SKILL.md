---
name: cv-security-check
description: Read-only security check of a project before it is committed or published. Checks secrets, private data, git hygiene, Docker configuration, and accepted-risk documentation against the checks and OWASP and CWE lists in cv-security-best-practice. Use when the user says "security check", asks if a project is ready to commit or publish, or asks for a security review of configuration. Tested in Claude Code and OpenAI Codex CLI. Other agentic coding hosts may use it at the agent's discretion.
---

# cv-security-check

Read-only. Reports findings and a verdict. Changes nothing.

## Host check

This skill was tested in Claude Code and OpenAI Codex CLI. In another agentic coding host, you may use it at your
discretion. Say which host you are running in, and note that the skill has not been tested there.

## Rules

- Read-only. No edits, no installs, and no network calls to the project's own services.
- Never run git. Ask the user to run git commands and paste the output, or read `.gitignore` and the file lists the user provides.
- Never print a secret value. Report the file and line only.
- Don't read `.env` files, logs, or any folder named `*-restricted`. Check their names and `.gitignore` coverage only.
- Accepted risks are recorded by the user in the project's own restricted register. Don't record them in the report.

## Reference

Read these from the `cv-security-best-practice` repository before checking:

1. `checks/operating-model.md`: fix levels and the credentials rule
2. `checks/git-hygiene.md`: `.gitignore`, tracked secrets, scanning, backups, source maps, history
3. `checks/secrets.md`: patterns and rules for hard-coded and logged secrets
4. `checks/docker.md`: D01–D10, if the project has a Dockerfile or compose file
5. `owasp/cwe-top25.md`: CWE IDs for findings

## Steps

1. **Classify the project.** Public if its README links to a public site or repository, or the user says so. When unsure, treat it as public.
2. **Inventory.** List the files, excluding `.git/`, `node_modules/`, `.venv/`, `__pycache__/`, and `dist/`.
3. **Secrets.** Apply the patterns in `checks/secrets.md`, checks 1 to 5. A real-looking value is **blocking**.
4. **Private data.** Look for private IPv4 addresses, local absolute paths, personal usernames, and real host names. Any match is **blocking**.
5. **Git hygiene.** Apply `checks/git-hygiene.md`, checks 1 to 6, from the file lists. For check 7 (history), ask the user to run the history scan and report the result.
6. **Docker.** If there is a Dockerfile or compose file, check D01–D10 against the file contents. A missing item is **stale**. Where the file gives no evidence either way, record it as a **gap**, not a pass.
7. **Accepted-risk documentation.** A known tradeoff in code needs a comment stating the risk and what bounds it. Missing is **stale**. For a public repository, the comment must not describe the weakness in detail.
8. **Logging.** Apply `checks/secrets.md`, check 3.

## Report

- **Blocking.** Real secrets, private data, a tracked `.env`, or a history match.
- **Stale.** Missing controls, missing accepted-risk comments, or wrong references. Give the CWE ID where one applies.
- **Gaps.** Checks the files gave no evidence for.

Then a verdict: **ready to commit**, or **not ready**, with the smallest set of changes that would make it ready.

## Fixes

This skill doesn't fix anything. Propose a change as a level 2 diff. Apply it only after explicit approval for that file, as set out in `checks/operating-model.md`.
