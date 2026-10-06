# CWE Top 25 Most Dangerous Software Weaknesses (2025)

Source: MITRE. Home: <https://cwe.mitre.org/top25/>. Archive: <https://cwe.mitre.org/top25/archive/2025/2025_cwe_top25.html>.
Checked 2026-10-05.

| Rank | CWE | Name | Common control |
|---|---|---|---|
| 1 | CWE-79 | Cross-site Scripting | Encode output for its context. Use `textContent`, not `innerHTML`. Set a Content Security Policy. |
| 2 | CWE-89 | SQL Injection | Use parameterized queries. |
| 3 | CWE-352 | Cross-Site Request Forgery | Use SameSite cookies and check request origin headers. |
| 4 | CWE-862 | Missing Authorization | Check authorization on every route and resource. |
| 5 | CWE-787 | Out-of-bounds Write | Allocate buffers with a checked size. |
| 6 | CWE-22 | Path Traversal | Normalize paths and restrict them to an allowed directory. |
| 7 | CWE-416 | Use After Free | Manage resource lifetimes explicitly. Relevant mainly to native code. |
| 8 | CWE-125 | Out-of-bounds Read | Check bounds on every read, especially with user-controlled sizes. |
| 9 | CWE-78 | OS Command Injection | Pass arguments as an array to an exec-style call. Never through a shell string. |
| 10 | CWE-94 | Code Injection | Don't evaluate dynamic code, and don't build code from input. |
| 11 | CWE-120 | Buffer Copy without Checking Size of Input | Check the size before every copy. |
| 12 | CWE-434 | Unrestricted Upload of File with Dangerous Type | Check file type from its contents. Limit size. Store uploads outside the web root. |
| 13 | CWE-476 | NULL Pointer Dereference | Check for null before use, especially on database results. |
| 14 | CWE-121 | Stack-based Buffer Overflow | Check the size before every copy. |
| 15 | CWE-502 | Deserialization of Untrusted Data | Don't deserialize untrusted input. Use safe loaders (for example, `yaml.safe_load`). |
| 16 | CWE-122 | Heap-based Buffer Overflow | Check the size before every copy. |
| 17 | CWE-863 | Incorrect Authorization | Check ownership on every resource. |
| 18 | CWE-20 | Improper Input Validation | Validate input against an allowlist and a schema. |
| 19 | CWE-284 | Improper Access Control | Enforce access at a single point, not in each caller. |
| 20 | CWE-200 | Exposure of Sensitive Information to an Unauthorized Actor | Return only the fields the caller needs. Keep errors generic. |
| 21 | CWE-306 | Missing Authentication for Critical Function | Require authentication on every sensitive function. |
| 22 | CWE-918 | Server-Side Request Forgery | Allowlist destinations before any outbound request. |
| 23 | CWE-77 | Command Injection | Don't build commands from strings. Avoid shell mode. |
| 24 | CWE-639 | Authorization Bypass Through User-Controlled Key | Look up objects with the authenticated user's scope, not a bare ID. |
| 25 | CWE-770 | Allocation of Resources Without Limits or Throttling | Set limits on size, rate, and concurrency. |

## Notes

- Memory-safety items (CWE-120, 121, 122, 787, 125, 416) apply to native code. Managed-language projects
  are less exposed, but the same ideas apply to any native library they call.
- The `Buffer` APIs in Node.js: `Buffer.alloc()` zero-fills memory. `new Buffer()` is deprecated.
