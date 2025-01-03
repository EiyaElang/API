const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware untuk CORS
app.use(cors());

// Middleware untuk parse JSON
app.use(bodyParser.json());

// Middleware logging (ditempatkan di sini)
app.use((req, res, next) => {
  console.log(`Request received: ${req.method} ${req.url}`);
  next();
});

// In-memory database
let catalog = [
  { id: 1, name: 'Polo Shirt' },
  { id: 2, name: 'T-Shirt' },
  { id: 3, name: 'Kaos Dalam' }
];

// CRUD operations

// Read all items
app.get('/catalog', (req, res) => {
  res.json(catalog);
});

// Read item by ID
app.get('/catalog/:id', (req, res) => {
  const item = catalog.find(c => c.id == req.params.id);
  if (item) {
    res.json(item);
  } else {
    res.status(404).send('Item not found');
  }
});

// Create item
app.post('/catalog', (req, res) => {
  const { name } = req.body;
  const newItem = {
    id: catalog.length + 1,
    name
  };
  catalog.push(newItem);
  res.status(201).json(newItem);
});

// Update item
app.put('/catalog/:id', (req, res) => {
  const { name } = req.body;
  let item = catalog.find(c => c.id == req.params.id);
  if (item) {
    item.name = name;
    res.json(item);
  } else {
    res.status(404).send('Item not found');
  }
});

// Delete item
app.delete('/catalog/:id', (req, res) => {
  catalog = catalog.filter(c => c.id != req.params.id);
  res.status(204).send();
});

// Start server
app.listen(port, () => {
  console.log(`API is running on http://localhost:${port}`);
});