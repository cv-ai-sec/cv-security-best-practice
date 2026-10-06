# Workflow best practices

Command references and security practices for the everyday tools behind a software project: git, Docker, and the runbook
format for changes that touch both a repository and a live service.

Each section gives the commands, the reason each step matters, and the security check to run before the step is trusted.

## Contents

| Path | What it covers |
|---|---|
| [git/README.md](git/README.md) | Git commands, pre-push secret checks, and commit hygiene |
| [git/scripts/](git/scripts/) | A preflight check that runs before every push (bash and PowerShell) |
| [docker/README.md](docker/README.md) | Docker and Compose commands, container hardening, networking, and debugging |
| [deploy-runbook-format.md](deploy-runbook-format.md) | Four-part runbook (commit, apply, verify, log) for changes that span a repo and a live service |

## Rules

- Commands in these pages use placeholders such as `<name>`, `<service>`, and `192.0.2.0/24` (a documentation range).
  Replace them with your own values.
- Nothing here is specific to one machine or one network. Keep it that way: add your own values only in local, restricted
  notes.
