# OWASP Top 10 for Agentic Applications (2026)

Source: <https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/>. Published December 2025 by the
OWASP GenAI Security Project. Checked 2026-10-05.

**Verification note:** the names below come from a secondary summary. The official page links to the full document, and the
names were not confirmed there. Check the official document before citing.

Risk shifts from bad output to unauthorized action once an LLM can call tools, hold memory, and run multi-step loops.

| ID | Risk |
|---|---|
| ASI01 | Agent Goal Hijack |
| ASI02 | Tool Misuse and Exploitation |
| ASI03 | Agent Identity and Privilege Abuse |
| ASI04 | Agentic Supply Chain Compromise |
| ASI05 | Unexpected Code Execution |
| ASI06 | Memory and Context Poisoning |
| ASI07 | Insecure Inter-Agent Communication |
| ASI08 | Cascading Agent Failures |
| ASI09 | Human-Agent Trust Exploitation |
| ASI10 | Rogue Agents |

## Common controls

- Controls outside the model hold even when the model is fooled: schema validation, scoped permissions, egress
  allowlists, and kill paths that don't depend on the agent.
- Controls that depend on the model following an instruction are advisory. Treat them as a second layer, not the first.
