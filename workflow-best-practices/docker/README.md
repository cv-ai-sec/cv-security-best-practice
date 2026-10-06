# Docker workflow best practices

A command reference for Docker and Compose, with hardening settings and the security check for each.

## Container lifecycle

| Command | What it does |
|---|---|
| `docker ps -a` | List all containers, including stopped ones. Check this on anything cloned or inherited |
| `docker start <name>` / `docker stop <name>` | Start or stop one container |
| `docker restart <name>` | Stop, then start |
| `docker logs --tail 50 <name>` | Last 50 log lines |
| `docker logs -f <name>` | Follow logs live |
| `docker exec -it <name> sh` | Shell into a running container (`bash` if the image has it) |
| `docker inspect <name>` | Full configuration: mounts, environment, networks |
| `docker stop <name>` then `docker rm <name>` | Remove a container. Stop first so the application shuts down cleanly |

**Security:** `docker inspect` shows environment variables, which can include secrets. Don't paste its output into a
ticket or a chat.

## Images

| Command | What it does |
|---|---|
| `docker build -t <name> .` | Build an image from the `Dockerfile` in this folder |
| `docker build --no-cache -t <name> .` | Rebuild without the cache. Use when an unpinned dependency must re-fetch |
| `docker history <image>` | Show each layer and its size |
| `docker image prune` | Remove untagged images |

**Security:** `docker history` shows every command that built a layer. A secret passed as a build argument or `ENV` is
visible here and in the image itself. Keep secrets out of the build.

## Compose

| Command | What it does |
|---|---|
| `docker compose up -d` | Start the stack in the background |
| `docker compose build <service>` | Rebuild one service. `up -d` alone does not pick up a `Dockerfile` change |
| `docker compose up -d --force-recreate <service>` | Recreate one service, for example after an environment change |
| `docker compose ps` | Check status. Look for `Up`, not `Restarting` |
| `docker compose logs -f <service>` | Follow one service's logs |
| `docker compose config` | Show the resolved file, with variables substituted. Check this before `up` |
| `docker compose down` | Stop and remove containers and networks. Sends a stop signal and waits |
| `docker compose down -v` | Also deletes named volumes. Destructive. Use only to wipe data on purpose |

**Security:** `docker compose config` prints environment values too. Run it in a terminal you control, not in a shared log.

## Hardening every service

Apply these to every service, not only the ones that seem risky. Consistency is easier to audit than judgment.

```yaml
services:
  app:
    image: <registry>/<image>:<tag>      # pinned tag or digest
    read_only: true
    tmpfs:
      - /tmp
    cap_drop:
      - ALL
    security_opt:
      - no-new-privileges:true
    mem_limit: 512m
    pids_limit: 200
```

| Setting | Why |
|---|---|
| `read_only: true` | The root filesystem cannot change at runtime. Writable paths are declared explicitly |
| `tmpfs: [/tmp]` | A scratch area that is not kept and not part of the image |
| `cap_drop: [ALL]` | Removes every Linux capability. Add one back only if a specific failure needs it |
| `no-new-privileges:true` | A process cannot gain privileges, for example through a setuid binary |
| `mem_limit`, `pids_limit` | Stops one container from exhausting the host |

## Non-root user with a fixed UID

```dockerfile
RUN groupadd -g 10001 app && useradd -u 10001 -g app -M -s /usr/sbin/nologin app
RUN mkdir -p /app/data && chown -R app:app /app
USER app
```

A fixed UID means the host can set bind-mount ownership once (`chown -R 10001:10001 ./data`) and keep it correct across
rebuilds. Without `USER`, the process runs as root.

## Pinning images

- Pin a version tag, not `latest`. `latest` changes under you.
- For production, pin the image digest: `image: <name>@sha256:<digest>`.
- Pull from a registry you trust. Check the digest before you pin it.

## Networking

| Command | What it does |
|---|---|
| `docker network ls` | List networks |
| `docker network inspect <name>` | Show the subnet and connected containers |

Declare a fixed subnet in Compose, so a host firewall rule has something stable to target:

```yaml
networks:
  app-net:
    driver: bridge
    ipam:
      config:
        - subnet: 192.0.2.0/24           # documentation range: replace with your own
```

**Security:**

- Don't set `internal: true` on a network that also publishes a port to the host. It can stop the published port from
  working, with no error at `docker compose up`.
- Docker's default bridge allows outbound traffic. If a container should not reach the internet, block it at the host
  firewall. Docker's network settings alone don't do that.
- Publish a port only on the interface it needs. Prefer `127.0.0.1:<host-port>:<container-port>` over an open
  `<host-port>:<container-port>`.

## Volumes and bind mounts

| Command | What it does |
|---|---|
| `docker volume ls` | List volumes |
| `docker volume inspect <name>` | Show where a volume lives and which containers use it |
| `docker volume rm <name>` | Remove an unused volume |

Bind mounts (`./data:/app/data`) are just host folders. On SELinux enforcing systems, add `:Z` (private to one container)
or `:z` (shared). Without it, the container may get `Permission denied` on a correct mount.

**Security:** never mount the Docker socket (`/var/run/docker.sock`) into a container that doesn't need to control Docker.
A container with the socket can start a privileged container on the host.

## Debugging a container that won't start or keeps restarting

1. `docker compose ps`: is it `Restarting` (crash loop) or just slow to become healthy?
2. `docker compose logs --tail 50 <service>`: the error is usually here.
3. `docker compose exec <service> sh`: if it stays up, check files, permissions, and network reachability directly.
4. Permission error on a bind mount: compare the host folder's owner (`ls -ln ./data`) with the UID in the `USER` line.
5. A `TypeError` or `ImportError` you didn't cause: a transitive dependency may have changed. Pin the full dependency set,
   not only the direct dependencies.

## Stopping safely

- Stop with `docker compose down` or `docker stop`. A hard kill can leave a database or a log file half-written.
- Use `docker compose down -v` only when you mean to delete the data.
