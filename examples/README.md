# Examples

Short side-by-side examples. Each topic has a file in `best-practices/` and a file of the same name in `avoid/`.

Read the `avoid/` file to see the pattern, then the matching `best-practices/` file to see the fix. The checks in
[checks/](../checks/) explain when each pattern matters.

**All values are placeholders.** No example contains a working credential, address, or host. The `avoid/` files are
deliberately wrong. Don't copy them into a project.

| Topic | Best practice | Avoid | Check |
|---|---|---|---|
| Secrets from the environment | [secrets-from-env.js](best-practices/secrets-from-env.js) | [secrets-hardcoded.js](avoid/secrets-hardcoded.js) | [secrets.md](../checks/secrets.md) |
| SQL queries | [sql-parameterized.js](best-practices/sql-parameterized.js) | [sql-string-concat.js](avoid/sql-string-concat.js) | CWE-89 |
| Running external commands | [command-exec-args.js](best-practices/command-exec-args.js) | [command-shell-string.js](avoid/command-shell-string.js) | CWE-78 |
| Rendering user text | [render-text.js](best-practices/render-text.js) | [render-innerhtml.js](avoid/render-innerhtml.js) | CWE-79 |
| Reading user-named files | [path-within-root.js](best-practices/path-within-root.js) | [path-join-user-input.js](avoid/path-join-user-input.js) | CWE-22 |
| Logging | [log-redacted.js](best-practices/log-redacted.js) | [log-full-request.js](avoid/log-full-request.js) | [secrets.md](../checks/secrets.md), check 3 |
| Container image | [Dockerfile](best-practices/Dockerfile) | [Dockerfile](avoid/Dockerfile) | [docker.md](../checks/docker.md), D01, D06 |
| Container runtime | [docker-compose.yml](best-practices/docker-compose.yml) | [docker-compose.yml](avoid/docker-compose.yml) | [docker.md](../checks/docker.md), D03, D05, D07 |
| Ignore rules | [gitignore](best-practices/gitignore) | [gitignore](avoid/gitignore) | [git-hygiene.md](../checks/git-hygiene.md), check 1 |
