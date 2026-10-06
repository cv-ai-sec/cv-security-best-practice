// BEST PRACTICE: run the program directly with an argument array. No shell is started, so the
// arguments can't be split or extended. Validate the names before use (see path-within-root.js).
const { execFile } = require("node:child_process");

function resizeImage(inputPath, outputPath, callback) {
  execFile("convert", [inputPath, "-resize", "800x600", outputPath], callback);
}

module.exports = { resizeImage };
