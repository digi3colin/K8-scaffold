const fs = require('fs');
const dbFilePath = './db/db.sqlite';

if(fs.existsSync(dbFilePath)){
  fs.unlinkSync(dbFilePath);
}
fs.writeFileSync(dbFilePath, '', {encoding: 'utf8'});


const Database  = require('better-sqlite3');
const sql = fs.readFileSync('./db/cms.sql', 'utf8');
const db = new Database(dbFilePath);
db.exec(sql);