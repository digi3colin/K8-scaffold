const {SQLITE, scaffold} = require('./index');

scaffold(
  `${__dirname}/db/db.sqlite`,
  `${__dirname}/db/db.sql`,
  `${__dirname}/exports/classes`,
  require('./db/schema')
);