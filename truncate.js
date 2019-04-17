const fs = require('fs');
const dbFilePath = './db/db.sqlite';

if(fs.existsSync(dbFilePath)){
  fs.unlinkSync(dbFilePath);
}
fs.writeFileSync(dbFilePath, '', {encoding: 'utf8'});


//const Database  = require('better-sqlite3');
//let sql = fs.readFileSync('../../cms.sql', {encoding: 'utf8'});

//const db = new Database('./db.sqlite');
//db.prepare(sql).run();