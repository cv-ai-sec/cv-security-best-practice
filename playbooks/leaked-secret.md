# Playbook: a secret has leaked

Use this when a credential is found in a repository, in its history, in logs, or in a public location.

## Principle

Treat the secret as compromised from the moment it was exposed. Removing it from the files doesn't undo the exposure.

## Steps

1. **Rotate first.** Issue a new credential at the provider and revoke the old one. Do this before any clean-up, because
   copies may already exist.
2. **Check for use.** Ask the provider for the access log for the old credential, if it offers one. Look for use from
   unknown locations or times.
3. **Remove from the current tree.** Replace the value with a reference to an environment variable or secret store. Commit
   the fix.
4. **Remove from history** (only for repositories where the history must not hold the secret). The user runs the history
   rewrite tool, such as `git-filter-repo`, and force-pushes. Warn collaborators that their clones must be re-created.
5. **Verify.** Run the history scan again (see [git-hygiene.md](../checks/git-hygiene.md), check 7). Confirm the old
   credential no longer works.
6. **Record.** Write a dated entry in the project's own audit log: what leaked, where, when it was rotated, and what was
   checked. Don't record the value.

## Notes

- Rewriting history doesn't help a copy that someone already cloned or forked. Rotation is the fix that matters.
- Public repositories: assume every secret pushed is already known to scrapers. Rotate first.
- The agent doesn't run the history rewrite or the rotation. It lists the steps and the commands for the user to run.
