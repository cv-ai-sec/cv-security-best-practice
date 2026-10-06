// AVOID: the input is joined into the SQL text. A crafted value changes the query's meaning (CWE-89).
async function findUserByEmail(db, email) {
  const result = await db.query("SELECT id, name FROM users WHERE email = '" + email + "'");
  return result.rows[0] ?? null;
}

module.exports = { findUserByEmail };
