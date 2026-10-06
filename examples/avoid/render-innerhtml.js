// AVOID: user text is parsed as HTML. A comment containing a script tag runs in every viewer's browser (CWE-79).
function showComment(element, comment) {
  element.innerHTML = comment;
}

module.exports = { showComment };
