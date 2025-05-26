const oracledb = require('oracledb');

async function getDBConnection() {
  // Abre una nueva conexión en cada llamada para evitar conexiones cerradas
  const connection = await oracledb.getConnection({
    user:         process.env.DBUSER,
    password:     process.env.DBPASS,
    connectString:`${process.env.DBHOST}:1521/${process.env.ORACLE_PDB}`
  });
  console.log('🟢 Oracle conectado');
  return connection;
}

module.exports = { getDBConnection };
