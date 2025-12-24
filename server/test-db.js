require("dotenv").config();
const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: { require: true, rejectUnauthorized: false }
});

(async () => {
  try {
    const r = await pool.query("SELECT now()");
    console.log("CONNECTED OK:", r.rows[0]);
    process.exit(0);
  } catch (e) {
    console.error("FAILED:", e.message);
    process.exit(1);
  }
})();
