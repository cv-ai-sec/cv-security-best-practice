// AVOID: the whole request is logged. The Authorization and Cookie headers, and any token in the body, are now in
// the log store and in every system that reads it (see secrets.md, check 3).
function logLogin(logger, req) {
  logger.info({ event: "login", headers: req.headers, body: req.body });
}

module.exports = { logLogin };
