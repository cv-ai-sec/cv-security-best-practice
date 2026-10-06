// BEST PRACTICE: read the secret from the environment and fail fast if it is missing.
// The value is set outside the code (a .env file that is not committed, or the platform's secret store).
const apiKey = process.env.PAYMENTS_API_KEY;
if (!apiKey) {
  throw new Error("PAYMENTS_API_KEY is not set. See .env.example for the variable name.");
}

module.exports = { apiKey };
