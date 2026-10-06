---
name: git-security
description: Read-only check of a git repository for loose credentials, sensitive and restricted information, and content that could give an AI agent an attack path. Covers credential files, agent and editor configuration that runs code or grants broad permissions, instruction-like text aimed at agents, and history. Use when the user says "git security", asks whether a repository is safe for an agent to work in, or asks what a repository exposes in its files or history. Tested in Claude Code and OpenAI Codex CLI. Other agentic coding hosts may use it at the agent's discretion.
---

# git-security

Read-only. Reports findings. Changes nothing.

## Host

This skill was tested in Claude Code and OpenAI Codex CLI. On another host, you may use it at your discretion. Name the
host in the report, and note that the skill is untested there.

## Rules

- **Never run git.** The user runs every git command. Ask the user to run the commands listed below and paste the output
  with values redacted. Read files from disk only where the user has supplied them.
- **Never print a secret value.** Report the file and line only.
- **Don't read** `.env` files, key files, logs, or any folder named `*-restricted`. Check their names and ignore coverage only.
- **Never store or request a credential.** If a value appears in the pasted output, say so and ask the user to rotate it.
- **Don't contact any service.** Don't test whether a found credential is live.

## Reference

Read these from the repository root before checking:

1. `checks/secrets.md`
2. `checks/git-hygiene.md`
3. `checks/operating-model.md`

## Commands for the user to run

```bash
git ls-files                                   # tracked files
git status --short --ignored                   # untracked and ignored files
git remote -v                                  # remote URLs (check for user:password@)
git submodule status                           # submodules
git log --all --name-only --format=          # files ever committed, including deleted ones
```

For the history scan, the user runs a dedicated scanner (for example gitleaks) over all commits and branches, and pastes
the summary. Don't ask for raw matches.

## Checks

### A. Loose credentials

1. **Secret patterns** in tracked files, using `checks/secrets.md`, checks 1 and 2. Real-looking values are **blocking**.
2. **Credentials in URLs.** Remote URLs or submodule URLs with a password or token in them are **blocking**.
3. **Credential files tracked.** Examples: `.npmrc` with an auth token, `.pypirc`, `.netrc`, a Docker `config.json` with
   `auths`, cloud CLI credential files, SSH private keys, and kubeconfig files. Any of these tracked is **blocking**.
4. **Credentials in agent and editor configuration.** Settings files for Claude Code, Codex, Cursor, Copilot, Windsurf,
   and Cline, and MCP server config, with a literal value in an `env` or `headers` field, are **blocking**.

### B. Sensitive and restricted information

5. **Private addresses, local paths, personal usernames, host names** in tracked files are **blocking** in a
   public repository. In a private repository they are **review**.
6. **Restricted material in the tree.** Folders or files whose names say they are restricted or private, and
   tracked files that refer to them by content, are **blocking**.
7. **Operator-only documents.** Accepted-risk registers, incident reports, runbooks, and operator-only documents that are tracked are
   **blocking** in a public repository. Check file names and the first lines of each file.
8. **Logs, audit records, and exports.** Session logs, audit logs, memory exports, and conversation transcripts that are
   tracked are **blocking**.

### C. Agent attack paths

9. **Automatic execution committed.** Configuration that runs a command when a folder opens, when a tool is used, or
   when a session starts. Examples: hooks in agent settings, `runOn: folderOpen` tasks, committed git hooks, and install
   scripts in `package.json`. Each one is **review**. Treat it as **blocking** if it runs a download or an unreviewed script.
10. **Broad agent permissions committed.** Allow-lists with wildcards for shell commands, network access, or file writes
    outside the project are **review**.
11. **Instruction-like text aimed at agents.** Files such as `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, and copilot
    instruction files that tell an agent to ignore rules, reveal configuration, fetch a URL, or hide an action are
    **blocking**. Also check for hidden characters (zero-width, bidirectional overrides) in those files.
12. **Agent memory committed.** Memory stores or saved conversation context tracked in the repository are **blocking**.
13. **Container control committed.** A reference to the Docker socket, `privileged: true`, or host mounts in a compose file
    or Dockerfile that an agent could reach is **review**. Check against `checks/docker.md`, D05.

### D. History

14. **Anything above in history.** A file deleted from the tree is still in the history. A secret in a deleted file is
    **blocking**, and follows the leaked-secret playbook (`playbooks/leaked-secret.md`).

## Steps

1. **Classify.** Public if the README links to a public site or repository, or the user says so. When unsure, treat it as public.
2. **Inventory.** Use the `git ls-files` output the user provides. Ignore vendored and build folders.
3. **Check** sections A to D.
4. **Ask** for the history scan summary if it hasn't been provided.
5. **Report** and give a verdict.

## Report

- **Blocking.** Live-looking credentials, tracked credential files, credentials in URLs, restricted or operator-only documents
  in a public repository, instruction-like text aimed at agents, and any history match.
- **Review.** Automatic execution, broad permissions, private data in a private repository, container control.
- **Gaps.** Checks with no evidence from the files or the output the user provided.

Verdict: **safe to share with an agent**, or **not yet**, with the smallest set of changes that would make it safe.

## Fixes

This skill doesn't change anything. Propose each fix as a level 2 diff. Apply it only after explicit approval for that file,
as set out in `checks/operating-model.md`.
