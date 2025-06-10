const express = require("express");
const cors = require("cors");
const cookieParser = require('cookie-parser');
require('dotenv').config();

const app = express();

// 1) Configura CORS correctamente
const allowedOrigins = [
  'http://localhost:3000',
  'http://client:3000',
];

app.use(cors({
  origin: (origin, callback) => {
    if (!origin) return callback(null, true);  // Postman, etc.
    if (allowedOrigins.includes(origin)) return callback(null, true);
    callback(new Error('Not allowed by CORS'));
  },
  credentials: true,
  methods: ['GET','POST','PUT','DELETE','OPTIONS'],
  allowedHeaders: [
    'Origin','X-Requested-With','Content-Type','Accept','Authorization'
  ]
}));

// 2) Manejo explícito de preflight OPTIONS (si no lo cubre cors)
app.options('*', (req, res) => {
  res.sendStatus(204);
});

// 3) Middleware de parsing (no bodyParser separado)
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// 4) Rutas
app.use('/api', require('./routes/flask'));
app.use('/db', require('./routes/dBApi'));

// 5) Arranque
const port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log(`Server ejecutandose en http://localhost:${port}`);
});
