// BEST PRACTICE: log the fields needed to trace an event. Never log headers, tokens, or whole request bodies.
function logLogin(logger, req, userId) {
  logger.info({ event: "login", userId, ip: req.ip, at: new Date().toISOString() });
}

module.exports = { logLogin };
