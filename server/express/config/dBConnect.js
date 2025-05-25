const oracledb = require('oracledb')
const path = require('path');
let connection;

async function getDBConnection() {
  if (!connection){
    connection = await oracledb.getConnection({
        user: process.env.DBUSER,
        password: process.env.DBPASS,
        connectString: `${process.env.DBHOST}:1521/XEPDB1`
    });
    console.log('🟢 Oracle conectado');
  }
  return connection;
}

module.exports = { getDBConnection };