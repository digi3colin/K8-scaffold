const fs = require('fs');
const Database  = require('better-sqlite3');

const {parse, insert} = require('./parse-schema');
const codeGen = require('./parse-model').exec;

module.exports = {
  scaffold : (dbFilePath, sqlFilePath, classPath, schemaModule) => {
    const schema = schemaModule.schema  || [];
    const samples= schemaModule.samples || [];
    const pragma = schemaModule.pragma  || [];

    //delete db
    if(fs.existsSync(dbFilePath))fs.unlinkSync(dbFilePath);
    fs.writeFileSync(dbFilePath, '', {encoding: 'utf8'});

    const sql = parse(schema);
    fs.writeFileSync(sqlFilePath, sql, {encoding: 'utf8'});

    const db = new Database(dbFilePath);
    db.exec(sql);

    const inserts = insert(samples);
    db.exec(inserts);

    pragma.forEach(x => db.exec(`PRAGMA ${x}`));

    codeGen(schema, classPath);
  },
  SQLITE            : {
    UNIQUE          : 'UNIQUE',
    NOT_NULL_UNIQUE : 'NOT NULL UNIQUE',
    NOT_NULL        : 'NOT NULL',
    NULL            : 'NULL',
    INT             : 'INTEGER',
    NUM             : 'REAL',
    TEXT            : 'TEXT',
    BLOB            : 'BLOB',
    BOOL            : 'BOOLEAN',
    TRUE            : 'TRUE',
    FALSE           : 'FALSE',
    DATE            : 'DATETIME',
  },
  codeGen      : require('./parse-model').exec,
  parseSchema  : (sqlFilePath, schema) => {
    const sql = parse(schema);
    fs.writeFileSync(sqlFilePath, sql, {encoding: 'utf8'});
  },
  parseSample  : (sqlFilePath, sample) =>{
    const sql = insert(sample);
    fs.writeFilesync(outputPath, sql, {encoding: 'utf8'});
  },
  insertSample : insert,
  uid: () => ( ( (Date.now() - 1563741060000) / 1000 ) | 0 ) * 100000 + ((Math.random()*100000) & 65535),
};