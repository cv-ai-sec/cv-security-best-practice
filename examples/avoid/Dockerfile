# AVOID
# - "latest" tag: the image changes under you (D02)
# - No USER line: the process runs as root (D01)
# - Secret written into the image layers, readable by anyone who pulls it (D06)
FROM node:latest

WORKDIR /app
ENV PAYMENTS_API_KEY=<example-real-looking-key-do-not-use>
COPY . .
RUN npm install

CMD ["node", "server.js"]
