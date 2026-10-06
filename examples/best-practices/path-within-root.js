// BEST PRACTICE: resolve the requested path, then confirm it is still inside the upload folder (CWE-22).
const path = require("node:path");
const fs = require("node:fs/promises");

const UPLOAD_ROOT = path.resolve("/srv/app/uploads");

async function readUpload(requestedName) {
  const target = path.resolve(UPLOAD_ROOT, requestedName);
  if (!target.startsWith(UPLOAD_ROOT + path.sep)) {
    throw new Error("Path is outside the upload folder");
  }
  return fs.readFile(target);
}

module.exports = { readUpload };
