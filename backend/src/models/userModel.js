const db = require('../config/db');

const formatUser = (row) => {
  if (!row) {
    return null;
  }

  return {
    id: row.id,
    national_id: row.national_id,
    first_name: row.first_name,
    last_name: row.last_name,
    email: row.email,
    phone: row.phone,
    role: row.role,
    created_at: row.created_at,
    updated_at: row.updated_at,
    password: row.password,
  };
};

const create = async ({ email, password, role, first_name, last_name, phone, national_id }) => {
  const query = `
    INSERT INTO users (email, password, role, first_name, last_name, phone, national_id)
    VALUES ($1, $2, $3, $4, $5, $6, $7)
    RETURNING id, national_id, first_name, last_name, email, phone, role, created_at, updated_at;
  `;
  const values = [email, password, role, first_name || null, last_name || null, phone || null, national_id || null];
  const result = await db.query(query, values);
  return result.rows[0];
};

const findByEmail = async (email) => {
  const query = `SELECT * FROM users WHERE email = $1 LIMIT 1;`;
  const result = await db.query(query, [email]);
  return formatUser(result.rows[0]);
};

const findById = async (id) => {
  const query = `SELECT * FROM users WHERE id = $1 LIMIT 1;`;
  const result = await db.query(query, [id]);
  return formatUser(result.rows[0]);
};

module.exports = {
  create,
  findByEmail,
  findById,
};
