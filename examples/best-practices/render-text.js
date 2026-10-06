// BEST PRACTICE: insert user text as text. The browser never parses it as HTML (CWE-79).
function showComment(element, comment) {
  element.textContent = comment;
}

module.exports = { showComment };
