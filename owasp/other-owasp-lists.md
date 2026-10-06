# Other OWASP lists

Each list links to its official source. Checked 2026-10-05.

| List | Edition | Status | Source |
|---|---|---|---|
| API Security Top 10 | 2023 | Current | <https://api-security.owasp.org/editions/2023/en/0x00-header> |
| Mobile Top 10 | 2024 | Current. Names checked against the official 2024 final release page. | <https://owasp.github.io/www-project-mobile-top-10/2023-risks> |
| Docker Top 10 | D01–D10 | Current | <https://owasp.org/www-project-docker-top-10/> |
| Serverless Top 10 | 2018 (first report) | **Archived.** Historical reference only. | <https://github.com/OWASP/Serverless-Top-10-Project> |
| Cloud-Native Application Security Top 10 | Draft, last updated April 2022 | Draft. Ten risks. | <https://owasp.org/www-project-cloud-native-application-security-top-10/> |

## API Security Top 10 (2023)

| ID | Risk |
|---|---|
| API1 | Broken Object Level Authorization |
| API2 | Broken Authentication |
| API3 | Broken Object Property Level Authorization |
| API4 | Unrestricted Resource Consumption |
| API5 | Broken Function Level Authorization |
| API6 | Unrestricted Access to Sensitive Business Flows |
| API7 | Server Side Request Forgery |
| API8 | Security Misconfiguration |
| API9 | Improper Inventory Management |
| API10 | Unsafe Consumption of APIs |

## Mobile Top 10 (2024)

| ID | Risk |
|---|---|
| M1 | Improper Credential Usage |
| M2 | Inadequate Supply Chain Security |
| M3 | Insecure Authentication/Authorization |
| M4 | Insufficient Input/Output Validation |
| M5 | Insecure Communication |
| M6 | Inadequate Privacy Controls |
| M7 | Insufficient Binary Protections |
| M8 | Security Misconfiguration |
| M9 | Insecure Data Storage |
| M10 | Insufficient Cryptography |

## Docker Top 10

Source for the list: <https://github.com/OWASP/Docker-Top-10>.

| ID | Control |
|---|---|
| D01 | Secure User Mapping |
| D02 | Patch Management Strategy |
| D03 | Network Segmentation and Firewalling |
| D04 | Secure Defaults and Hardening |
| D05 | Maintain Security Contexts |
| D06 | Protect Secrets |
| D07 | Resource Protection |
| D08 | Container Image Integrity and Origin |
| D09 | Follow Immutable Paradigm |
| D10 | Logging |

## Serverless Top 10 (archived)

Historical reference only, using the 2017 names: S1 Injection, S2 Broken Authentication, S3 Sensitive Data Exposure,
S4 XML External Entities, S5 Broken Access Control, S6 Security Misconfiguration, S7 Cross-Site Scripting,
S8 Insecure Deserialization, S9 Using Components with Known Vulnerabilities, S10 Insufficient Logging and Monitoring.

## Cloud-Native Application Security Top 10 (draft)

| ID | Risk |
|---|---|
| CNAS-1 | Insecure cloud, container or orchestration configuration |
| CNAS-2 | Injection flaws (app layer, cloud events, cloud services) |
| CNAS-3 | Improper authentication and authorization |
| CNAS-4 | CI/CD pipeline and software supply chain flaws |
| CNAS-5 | Insecure secrets storage |
| CNAS-6 | Over-permissive or insecure network policies |
| CNAS-7 | Using components with known vulnerabilities |
| CNAS-8 | Improper assets management |
| CNAS-9 | Inadequate compute resource quota limits |
| CNAS-10 | Ineffective logging and monitoring (e.g. runtime activity) |
