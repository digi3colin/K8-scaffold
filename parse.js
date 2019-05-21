const fs = require('fs');

const pluralize = require('pluralize');
const camelCase = require('camelcase');
const capitalize = require('capitalize');
const Database  = require('better-sqlite3');

const schema = require('./db/schema.js.bak');

const s = (v, prefix = '') => (v ? ` ${prefix}${v}` : '');

const sql = schema.map(x => {
  const lines = [];
  lines.push('id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL');
  lines.push('created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL');
  lines.push('updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL');

  const onDeletes = [];

  x.extends.forEach(y => Object.keys(y.fields).forEach(z => lines.push(`${z} ${y.fields[z][0]}${s(y.fields[z][1])}${s(y.fields[z][2], 'DEFAULT ')}`)));

  Object.keys(x.fields).forEach(z => lines.push(`${z} ${x.fields[z][0]}${s(x.fields[z][1])}${s(x.fields[z][2], 'DEFAULT ')}`));

  x.belongs_to.forEach(y => {
    const table = y;
    const fk    = pluralize.singular(y)+'_id';
    lines.push(`${fk} INTEGER NOT NULL`);
    onDeletes.push(`FOREIGN KEY (${fk}) REFERENCES ${table} (id) ON DELETE CASCADE`);
  });

  x.associate_to.forEach(y => {
    if(typeof y === 'string'){
      const table = y;
      const fk    = pluralize.singular(y) + '_id';

      lines.push(`${fk} INTEGER`);
      onDeletes.push(`FOREIGN KEY (${fk}) REFERENCES ${table} (id) ON DELETE SET NULL`);
    }else{
      const key = Object.keys(y).join('');
      const table = y[key];
      const fk    = key + '_id';
      lines.push(`${fk} INTEGER`);
      onDeletes.push(`FOREIGN KEY (${fk}) REFERENCES ${table} (id) ON DELETE SET NULL`);
    }
  });

  const belongs_many = x.has_and_belongs_to_many.map(
    y =>
      `
CREATE TABLE ${pluralize.singular(x.table)}_${y}(
${pluralize.singular(x.table)}_id INTEGER NOT NULL,
${pluralize.singular(y)}_id INTEGER NOT NULL,
FOREIGN KEY (${pluralize.singular(x.table)}_id) REFERENCES ${x.table} (id) ON DELETE CASCADE ,
FOREIGN KEY (${pluralize.singular(y)}_id) REFERENCES ${y} (id) ON DELETE CASCADE
);
`
  ).join('\n');

  return`
CREATE TABLE ${x.table}(
${lines.concat(onDeletes).join(' ,\n')}
);

CREATE TRIGGER ${x.table}_updated_at AFTER UPDATE ON ${x.table} WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE ${x.table} SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;

${belongs_many}
`
});

fs.writeFile('sample.sql', sql.join('\n'), err => {if(err)console.log(err);});