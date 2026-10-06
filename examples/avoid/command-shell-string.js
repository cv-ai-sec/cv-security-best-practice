// AVOID: the command is built as one string and run through a shell (CWE-78, CWE-77).
// A file name containing shell characters adds commands of its own.
const { exec } = require("node:child_process");

function resizeImage(inputPath, outputPath, callback) {
  exec("convert " + inputPath + " -resize 800x600 " + outputPath, callback);
}

module.exports = { resizeImage };
