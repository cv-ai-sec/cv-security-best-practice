# Operating model

Tested with **Claude Code** and **OpenAI Codex CLI**. Other agentic coding hosts may use this material at their
discretion, but it has not been tested there.

## Hosts

- The checks were tested in Claude Code and Codex CLI.
- On another host, the agent may run the checks at its discretion. It should name the host in the report and note that
  the checks are untested there.
- The read-only and no-git rules apply on every host.

## Read-only by default

- A check reads files and reports. It doesn't edit files.
- A fix is a separate step, and it needs explicit approval for each change.

## Fix approval levels

| Level | Action | Approval |
|---|---|---|
| 1. Report | Detect and explain | None needed |
| 2. Propose | Show the exact change as a diff | None needed to show |
| 3. Apply | Edit a file | Explicit approval for that file and change |
| 4. Blocking | Stop. The user decides and applies | User decides |

Never change a file that could break a deployment or a live service without a level 4 review.

## Git

- The agent never runs git, and never stores git credentials, tokens, or SSH keys.
- Authentication is done by the user, outside the agent.
- For git checks, the agent reads `.gitignore` and the file lists the user provides. The user runs the git commands.

## Credentials

- Never print a real secret value. Report the file and line only.
- Never store a credential in any file in this repository, or in agent memory.

## Scope of exceptions

- The user decides which findings are accepted risks. An accepted risk is recorded in the project's own restricted
  register, not here.
