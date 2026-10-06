# OWASP ASVS 5.0: chapter map

Source: OWASP Application Security Verification Standard, project page
<https://owasp.org/www-project-application-security-verification-standard/> and the 5.0 chapter files at
<https://github.com/OWASP/ASVS/tree/master/5.0/en>. Checked 2026-10-05.

This file maps to chapters only. Requirement IDs (for example `V6.4.1`) differ between ASVS versions. Check the 5.0 chapter
file for each ID before citing it. Older numbering (ASVS 4.0) does not carry over.

| ID | Chapter | Relevant checks in this repository |
|---|---|---|
| V1 | Encoding and Sanitization | Output encoding for web and template output (CWE-79) |
| V2 | Validation and Business Logic | Input validation (CWE-20) |
| V3 | Web Frontend Security | Browser-side controls, CSP |
| V4 | API and Web Service | API authorization and input rules |
| V5 | File Handling | Uploads (CWE-434), path traversal (CWE-22) |
| V6 | Authentication | Credentials, password storage, lockout (CWE-287, CWE-306) |
| V7 | Session Management | Session lifetime and fixation |
| V8 | Authorization | Access checks on every resource (CWE-862, CWE-863) |
| V9 | Self-contained Tokens | JWT and similar tokens |
| V10 | OAuth and OIDC | Delegated login |
| V11 | Cryptography | Algorithms, key handling |
| V12 | Secure Communication | TLS settings |
| V13 | Configuration | Secrets management and configuration hygiene (CWE-798) |
| V14 | Data Protection | Storage and transmission of sensitive data |
| V15 | Secure Coding and Architecture | Dangerous functions, dependencies |
| V16 | Security Logging and Error Handling | Logs without secrets, safe error output |
| V17 | WebRTC | Only if the project uses WebRTC |

## Notes

- V13 is the closest 5.0 chapter to secrets management. Confirm the requirement IDs in that chapter before citing them.
- The `V6.4` and `V2.10` references in some older material are ASVS 4.0 numbering. Don't carry them into 5.0 citations.
