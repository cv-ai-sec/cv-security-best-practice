# Deploy runbook format: A, B, C, D

Use this shape when a change spans a repository on your workstation and a live service somewhere else, such as a VM or
a container stack. Give the steps as four labelled sections, always in this order, never merged into one block.

**A. On the workstation: secret scan, commit, push**
**B. On the target: pull, apply, rebuild or restart**
**C. Verify from the workstation, as a client**
**D. Log the change**

## Why four sections

Each section runs in a different place, carries different risk, and answers a different question.

| Section | Runs where | Question | Reversibility |
|---|---|---|---|
| A | Workstation, the repository | Is the change durable? | Easy: local commits can be amended or dropped before a push |
| B | The target, over SSH | Is the change live? | Harder: touches running services and firewall state |
| C | Workstation, as a client | Does it work from outside? | Read-only |
| D | A separate local log | Will someone later know why it changed? | Record only |

## Order matters

- **A before B.** Never deploy uncommitted work. A failed deploy should roll back to a clean commit.
- **B before C.** A change that isn't deployed can't be verified.
- **C before D.** The log should record what is active, not what was intended. A failed reload or a crash-looping
  container must not be logged as done.
- **A and C are separate.** A is "the change is saved." C is "the deployed thing behaves correctly." A successful commit
  says nothing about runtime success.

## Who runs what

- A and D are for a person to run. D records a decision, and a person should own that record.
- B and C can be run with help, but a person should check each command's output before the next one runs.

## Template

````markdown
### A. On the workstation: secret scan, commit, push

```bash
<secret scan from workflow-best-practices/git>
git add <named files>
git commit -m "<what changed and why>"
git push
```

### B. On the target: pull, apply, rebuild

```bash
ssh <user>@<target>
cd <checkout>
git pull
docker compose build <service>
docker compose up -d <service>
```

### C. Verify from the workstation

```bash
curl -fsS https://<service-address>/<health-path>
docker compose ps        # run on the target: look for Up, not Restarting
```

### D. Log the change

Record the date, what changed, the exact command, and whether it is still active, in the change log for that system.
````

## Notes

- Replace every `<...>` with your own values, and keep real addresses and host names out of any public copy.
- If a step has no target (nothing is deployed elsewhere), use A alone, plus D if the change affects system state.
