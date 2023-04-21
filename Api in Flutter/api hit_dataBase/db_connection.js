// Create Database Connection
const {Client} = require('pg');

const client = new Client({
  host: 'localhost',
  user: 'postgres',
  password: 'postgres',
  database: 'postgres',
  port: 54321
});

client.connect();

module.exports = client;