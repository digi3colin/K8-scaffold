const dbFilePath = './db/db.sqlite';
const {schema, samples} = require('./db/schema');

const fs = require('fs');

//delete db
if(fs.existsSync(dbFilePath))fs.unlinkSync(dbFilePath);
fs.writeFileSync(dbFilePath, '', {encoding: 'utf8'});

const Database  = require('better-sqlite3');
const db = new Database(dbFilePath);
const {parse, insert} = require('./parse-schema');
db.exec(parse(schema));

const inserts = insert(samples);
db.exec(inserts);

const codeGen = require('./parse-model');
codeGen.exec(schema);