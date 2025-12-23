// ----------------------------
//  IMPORTS
// ----------------------------
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const dotenv = require('dotenv');

dotenv.config(); // Load .env variables


// ----------------------------
//  EXPRESS APP SETUP
// ----------------------------
const app = express();
const port = process.env.PORT || 5000;

app.use(cors());             // Enable CORS
app.use(express.json());     // Allow JSON request bodies


// ----------------------------
//  MYSQL CONNECTION (POOL + RETRY)
// ----------------------------
const pool = mysql.createPool({
  host: process.env.DB_HOST,       // should be "db" inside Docker
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,

  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Simple retry loop to wait for MySQL to be ready (helps on first startup)
async function waitForDB(retries = 30, delayMs = 2000) {
  for (let i = 1; i <= retries; i++) {
    try {
      await pool.promise().query("SELECT 1");
      console.log("Connected to MySQL database");
      return;
    } catch (err) {
      console.log(`MySQL not ready yet (attempt ${i}/${retries}). Waiting...`);
      if (i === retries) {
        console.error("MySQL never became ready. Last error:", err.message);
        throw err;
      }
      await new Promise((r) => setTimeout(r, delayMs));
    }
  }
}



// ----------------------------
//  ROUTES
// ----------------------------

// Root route (test)
app.get('/', (req, res) => {
    res.send('Server is running');
});

// Fetch clients route
// Get clients with summary counts
app.get('/api/clients', (req, res) => {

  const sql = `
    SELECT 
      c.*,
      (SELECT COUNT(*) FROM payments p WHERE p.client_id = c.id) AS payment_count,
      (SELECT COUNT(*) FROM tasks t WHERE t.client_id = c.id) AS task_count
    FROM clients c
    ORDER BY c.name ASC
  `;

  pool.query(sql, (err, results) => {
    if (err) {
      console.error("Error fetching clients:", err);
      return res.status(500).json({ message: "Error fetching clients" });
    }

    res.json(results);
  });
});

// Update a client
app.put('/api/clients/:id', (req, res) => {
  const { id } = req.params;
  const { name, email, region, status } = req.body;

  if (!name || !email || !region || !status) {
    return res.status(400).json({ message: "All fields required" });
  }

  const sql = `
    UPDATE clients
    SET name = ?, email = ?, region = ?, status = ?
    WHERE id = ?
  `;

  pool.query(sql, [name, email, region, status, id], (err) => {
    if (err) {
      console.error("Error updating client:", err);
      return res.status(500).json({ message: "Update failed" });
    }

    res.json({ message: "Client updated successfully" });
  });
});



// Delete a client
app.delete('/api/clients/:id', (req, res) => {
  const { id } = req.params;

  const sql = "DELETE FROM clients WHERE id = ?";

  pool.query(sql, [id], (err) => {
    if (err) {
      console.error("Error deleting client:", err);
      return res.status(500).json({ message: "Error deleting client" });
    }

    res.json({ message: "Client deleted successfully" });
  });
});


// POST Client to DB
app.post('/api/clients', (req, res) => {
    const { name, email, status, region } = req.body;

    if (!name || !email || !status || !region) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    const sql = `INSERT INTO clients (name, email, status, region) VALUES (?, ?, ?, ?)`;

    pool.query(sql, [name, email, status, region], (err, result) => {
        if (err) {
            console.error('Error inserting client:', err);
            return res.status(500).json({ message: 'Database error' });
        }

        res.json({ message: 'Client added successfully', clientId: result.insertId });
    });
});

//Get payments for a client
// Get all payments for a specific client
app.get('/api/clients/:id/payments', (req, res) => {
  const { id } = req.params;

  const sql = `
    SELECT id, amount, status, created_at
    FROM payments
    WHERE client_id = ?
    ORDER BY created_at DESC
  `;

  pool.query(sql, [id], (err, results) => {
    if (err) {
      console.error("Error fetching client payments:", err);
      return res.status(500).json({ message: "Error loading payments" });
    }

    res.json(results);
  });
});


// Get all tasks for a specific client
app.get('/api/clients/:id/tasks', (req, res) => {
  const { id } = req.params;

  const sql = `
    SELECT id, subject, priority, due_date
    FROM tasks
    WHERE client_id = ?
    ORDER BY due_date DESC
  `;

  pool.query(sql, [id], (err, results) => {
    if (err) {
      console.error("Error fetching client tasks:", err);
      return res.status(500).json({ message: "Error loading tasks" });
    }

    res.json(results);
  });
});



// Fetch payment summary for dashboard
app.get('/api/payments/summary', (req, res) => {
    const sql = `
        SELECT
            SUM(CASE WHEN status = 'Approved' THEN amount ELSE 0 END) AS approved,
            SUM(CASE WHEN status = 'Pending' THEN amount ELSE 0 END) AS pending,
            SUM(amount) AS total
        FROM payments
    `;

    pool.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching payment summary:', err);
            return res.status(500).json({ message: 'Database error' });
        }

        res.json(results[0]);
    });
});


// Monthly earnings (last 12 months)
app.get('/api/payments/monthly', (req, res) => {
  const sql = `
    SELECT 
      DATE_FORMAT(created_at, '%Y-%m') AS month,
      SUM(amount) AS total
    FROM payments
    WHERE status = 'Approved'
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
    ORDER BY month ASC
  `;

  pool.query(sql, (err, results) => {
    if (err) {
      console.error("Error fetching monthly earnings:", err);
      return res.status(500).json({ message: "Database error" });
    }
    res.json(results);
  });
});



//Add Payment
app.post('/api/payments', (req, res) => {
  const { client_id, amount, status, date } = req.body;

  if (!client_id || !amount || !status || !date) {
    return res.status(400).json({ message: 'All fields are required.' });
  }

  const sql = `
    INSERT INTO payments (client_id, amount, status, created_at)
    VALUES (?, ?, ?, ?)
  `;

  pool.query(sql, [client_id, amount, status, date], (err, result) => {
    if (err) {
      console.error('Error inserting payment:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    res.json({ message: 'Payment added successfully', id: result.insertId });
  });
});



// Delete a payment
app.delete('/api/payments/:id', (req, res) => {
  const { id } = req.params;

  const sql = "DELETE FROM payments WHERE id = ?";

  pool.query(sql, [id], (err) => {
    if (err) {
      console.error("Error deleting payment:", err);
      return res.status(500).json({ message: "Error deleting payment" });
    }

    res.json({ message: "Payment deleted successfully" });
  });
});




// Create a New Task
app.post('/api/tasks', (req, res) => {
  const { client_id, subject, description, priority, due_date } = req.body;

  if (!client_id || !subject || !priority || !due_date) {
    return res.status(400).json({ message: 'Missing required fields.' });
  }

  const sql = `
    INSERT INTO tasks (client_id, subject, description, priority, due_date)
    VALUES (?, ?, ?, ?, ?)
  `;

  pool.query(sql, [client_id, subject, description, priority, due_date], (err, result) => {
    if (err) {
      console.error('Error inserting task:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    res.json({ message: 'Task added', taskId: result.insertId });
  });
});


// Fetch Today's Tasks
app.get('/api/tasks/today', (req, res) => {
  const sql = `
    SELECT t.*, c.name AS client_name
    FROM tasks t
    JOIN clients c ON c.id = t.client_id
    WHERE t.due_date = CURDATE()
  `;

  pool.query(sql, (err, results) => {
    if (err) {
      console.error('Error fetching tasks:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    res.json(results);
  });
});


//Fetch Tasks by date
app.get('/api/tasks/by-date', (req, res) => {
  const { date } = req.query;

  if (!date) {
    return res.status(400).json({ message: 'Date is required' });
  }

  const sql = `
    SELECT t.*, c.name AS client_name
    FROM tasks t
    JOIN clients c ON c.id = t.client_id
    WHERE t.due_date = ?
  `;

  pool.query(sql, [date], (err, results) => {
    if (err) {
      console.error('Error fetching tasks by date:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    res.json(results);
  });
});



// Client Search
app.get('/api/clients/search', (req, res) => {
  const search = req.query.q;

  const sql = `
    SELECT id, name
    FROM clients
    WHERE name LIKE ?
    LIMIT 20
  `;

  pool.query(sql, [`%${search}%`], (err, results) => {
    if (err) {
      console.error('Search error:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    res.json(results);
  });
});



// ----------------------------
//  START SERVER
// ----------------------------
waitForDB()
  .then(() => {
    app.listen(port, () => {
      console.log(`Server running on port ${port}`);
    });
  })
  .catch(() => {
    process.exit(1);
  });

