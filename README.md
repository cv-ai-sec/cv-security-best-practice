# cv-security-best-practice

Informational reference for application security: the current OWASP and MITRE lists, the checks built on them, and the
playbooks for common incidents.

Reference only. This repository contains no code, no configuration, and no secrets.

**Tested with Claude Code and OpenAI Codex CLI.** Other agentic coding hosts may use it at their discretion.

## Contents

### Lists

| Path | What it is |
|---|---|
| [owasp/web-top10.md](owasp/web-top10.md) | OWASP Top 10 (2025) for web applications |
| [owasp/llm-top10.md](owasp/llm-top10.md) | OWASP Top 10 for LLM Applications (2025) |
| [owasp/agentic-ai-top10.md](owasp/agentic-ai-top10.md) | OWASP Top 10 for Agentic Applications (2026) |
| [owasp/cwe-top25.md](owasp/cwe-top25.md) | MITRE CWE Top 25 Most Dangerous Software Weaknesses (2025) |
| [owasp/asvs.md](owasp/asvs.md) | OWASP ASVS 5.0, chapter map |
| [owasp/other-owasp-lists.md](owasp/other-owasp-lists.md) | OWASP API Security (2023), Mobile (2024), Docker, Serverless (archived), and Cloud-Native lists |
| [owasp/secure-controls-checklist.md](owasp/secure-controls-checklist.md) | A 25-category checklist of security areas. Not a published standard. |

### Checks

| Path | What it covers |
|---|---|
| [checks/operating-model.md](checks/operating-model.md) | Which hosts run the checks, read-only default, fix approval levels, and the credentials rule |
| [checks/git-hygiene.md](checks/git-hygiene.md) | `.gitignore`, tracked secrets, pre-commit scanning, backups, source maps, and git history |
| [checks/secrets.md](checks/secrets.md) | Hard-coded secrets, secrets in comments, logs, and URLs, and placeholder rules |
| [checks/docker.md](checks/docker.md) | Container checks mapped to the OWASP Docker Top 10 (D01–D10) |

### Skill

| Path | What it is |
|---|---|
| [skills/cv-security-check/SKILL.md](skills/cv-security-check/SKILL.md) | `cv-security-check`: a read-only check of a project against these checks. Tested in Claude Code and Codex CLI. |
| [skills/git-security/SKILL.md](skills/git-security/SKILL.md) | `git-security`: a read-only check of a git repository for loose credentials, sensitive information, and agent attack paths. Tested in Claude Code and Codex CLI. |
| [AGENTS.md](AGENTS.md) | Instructions for Codex CLI, and the rules every agent follows here |

### Workflow

| Path | What it is |
|---|---|
| [workflow-best-practices/](workflow-best-practices/README.md) | Git and Docker command references with the security check for each step, and the A/B/C/D deploy runbook format |

### Examples

| Path | What it is |
|---|---|
| [examples/](examples/README.md) | Best-practice and avoid versions side by side, for secrets, SQL, commands, output, paths, logs, Docker, and ignore rules. Placeholders only. |

### Playbooks

| Path | When to use it |
|---|---|
| [playbooks/leaked-secret.md](playbooks/leaked-secret.md) | A credential has been exposed in a repository, its history, or a log |

## Sources

Each file links to its official source. Check the official page for current wording before citing a list in your own
work. The date each list was last checked is in the file header.

The checks and the 25-category checklist were inspired by
[Netxeo/skill-file-security](https://github.com/Netxeo/skill-file-security) (MIT). No text was copied. Its ASVS
section numbers are from ASVS 4.0, so they were re-mapped to 5.0 chapters here.
