# Agent instructions

This repository is tested with Claude Code and OpenAI Codex CLI. Other agentic coding hosts may use it at their discretion.

- To run a security check, follow [skills/cv-security-check/SKILL.md](skills/cv-security-check/SKILL.md). For a git repository check, follow [skills/git-security/SKILL.md](skills/git-security/SKILL.md). It is read-only.
- Never run git. The user runs every git command.
- Never store credentials, tokens, or SSH keys in this repository or in agent memory.
- Never print a secret value. Report the file and line only.
- Every check is listed in [checks/](checks/). Read the relevant file before you check.
