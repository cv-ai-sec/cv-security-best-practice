# BEST PRACTICE
# - Pinned base image version, not "latest" (D02)
# - Runs as a non-root user (D01)
# - No secrets in ENV or ARG; they are injected at runtime (D06)
FROM node:20.11-slim

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force
COPY . .

USER node
EXPOSE 3000
CMD ["node", "server.js"]
