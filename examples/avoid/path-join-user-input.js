// AVOID: the requested name is joined to the folder without a check. A name such as "../../" reads files
// outside the folder (CWE-22). path.join normalises the path but does not confine it.
const path = require("node:path");
const fs = require("node:fs/promises");

const UPLOAD_ROOT = "/srv/app/uploads";

async function readUpload(requestedName) {
  return fs.readFile(path.join(UPLOAD_ROOT, requestedName));
}

module.exports = { readUpload };
