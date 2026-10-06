// BEST PRACTICE: the user's input is passed as a parameter, never joined into the SQL text.
// Example uses node-postgres style placeholders ($1).
async function findUserByEmail(db, email) {
  const result = await db.query("SELECT id, name FROM users WHERE email = $1", [email]);
  return result.rows[0] ?? null;
}

module.exports = { findUserByEmail };
