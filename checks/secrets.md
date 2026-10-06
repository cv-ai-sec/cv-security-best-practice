# Secrets checks

Detection patterns and rules for finding real secrets in files. The agent reports the file and line only, and never prints
the value.

## 1. Hard-coded secrets in code

- **Detect** values for known key formats (examples: `AKIA[0-9A-Z]{16}` for AWS access keys, `sk-` followed by 20 or more
  characters, `AIza` followed by 35 characters for Google API keys, and `-----BEGIN ... PRIVATE KEY-----`).
- **Detect** assignments to names such as `api_key`, `apikey`, `secret`, `password`, or `token` where the value is not a
  placeholder. A placeholder is `<...>`, `your_...`, `change_me`, or an empty string.
- **Explain:** a secret in code is readable by anyone with the repository, and by anyone with a copy of its history.
- **Fix:** move the value to an environment variable or the platform's secret store. Replace the literal with a reference
  to that variable. Then treat the value as exposed.
- **Exclude** test fixtures only when they are clearly labelled fake. Note each exclusion in the report.

## 2. Secrets in comments

- **Detect** the same patterns inside comments and docstrings.
- **Explain:** comments are code. They're committed, reviewed, and copied like code.
- **Fix:** remove the value and rotate it.

## 3. Secrets in logs and error output

- **Detect** logging calls that print environment variables, request headers (`Authorization`, `Cookie`), or full
  configuration objects.
- **Explain:** logs are often shipped to a shared system with weaker access control.
- **Fix:** log only the fields needed, and redact the rest before the log call.

## 4. Secrets in URLs

- **Detect** query strings or URLs containing `token=`, `key=`, `password=`, or credentials in the form
  `user:password@host`.
- **Explain:** URLs end up in logs, browser history, and proxy records.
- **Fix:** send the credential in a header or request body.

## 5. Placeholder discipline in examples

- **Detect** documentation or example files that contain values that look real.
- **Explain:** readers copy examples. A real-looking example trains them to use real values.
- **Fix:** use obvious placeholders (`<token>`, `see .env`).

## What the agent does not do

- It doesn't test whether a found secret is still live. It doesn't call any service to check.
- It doesn't repeat the value in the report. Report `file:line` and the pattern name.
