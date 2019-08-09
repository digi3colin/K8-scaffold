const dbFilePath = './db/db.sqlite';
const {schema, samples} = require('./db/schema');
const Database  = require('better-sqlite3');
const codeGen = require('./parse-model');
const {parse, insert} = require('./parse-schema');

const fs = require('fs');

//delete db
if(fs.existsSync(dbFilePath))fs.unlinkSync(dbFilePath);
fs.writeFileSync(dbFilePath, '', {encoding: 'utf8'});

const db = new Database(dbFilePath);
db.exec(parse(schema));

const inserts = insert(samples);
db.exec(inserts);

codeGen.exec(schema);