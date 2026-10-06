# Docker checks

Checks for container images and Docker configuration, mapped to the OWASP Docker Top 10 (D01–D10). Check each item against
its file evidence. Where the evidence is missing, say so in the report rather than assuming a pass.

| ID | Control | Detect in files | Fix |
|---|---|---|---|
| D01 | Secure User Mapping | No `USER` line, or `USER root`, in the final stage of a Dockerfile | Create a non-root user and set `USER` to it |
| D02 | Patch Management Strategy | Base image tag is `latest`, or no image version is pinned | Pin the image to a specific version and update on a schedule |
| D03 | Network Segmentation and Firewalling | Compose file puts all services on one default network | Give services separate networks, and expose only the ports a service needs |
| D04 | Secure Defaults and Hardening | Packages installed with recommended extras, no cleanup of package caches | Install only what's needed, and clear caches in the same layer |
| D05 | Maintain Security Contexts | `privileged: true`, added capabilities, or the Docker socket mounted into a container | Remove the privilege. Drop capabilities. Don't mount the socket into anything that doesn't need it |
| D06 | Protect Secrets | Secrets set with `ENV` or `ARG` in a Dockerfile, or in plain text in compose | Inject secrets at runtime through a secrets mechanism or an env file that is not committed |
| D07 | Resource Protection | No memory, CPU, or process limits set in compose | Set limits for each service |
| D08 | Container Image Integrity and Origin | Images pulled from unverified sources, or no digest pin | Pin by digest for production. Use images from a trusted registry |
| D09 | Follow Immutable Paradigm | Container filesystem is writable with no need | Use a read-only root filesystem, and mount only the writable paths the service needs |
| D10 | Logging | No logging configured, or logs stay inside the container | Send logs to a central collector, and keep their timestamps |

## Notes

- A check passes when the evidence is present in the files. A missing file is a gap, not a pass.
- For D03, D07, and D09, the right values depend on the service. Propose them as level 2 changes, not as edits.
- Accepted risks belong in the project's restricted register, not in this repository.
