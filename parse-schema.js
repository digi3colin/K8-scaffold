const pluralize = require('pluralize');
const camelCase = require('camelcase');
const capitalize = require('capitalize');
const snakeCase = require('snake-case');

const validateSchema = (data) => {
  if(!Array.isArray(data))return false;

  data.forEach(x => {
    if(Object.keys(x).length !== 1)return false;
  });

  return true;
};

//console.log(schema);
const s = (v, prefix = '') => (v ? (v === '' ? v : ` ${prefix}${v}`) : '');

function parse(model){
  const key = Object.keys(model).join('');
  const table = snakeCase(key);

  const def = getDef(model);

  const lines = [];
  const onDeletes = [];

  lines.push(`id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL`);
  lines.push(`uid INTEGER UNIQUE DEFAULT ( ( strftime('%s','now') - 1560268800 ) * 1000 + ABS(RANDOM()%1000) ) NOT NULL`);
  lines.push(`created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL`);
  lines.push(`updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL`);

  //extends
  def.extends.forEach(
      y => {
        Object
            .keys(y.fields)
            .forEach(z => lines.push(`${z} ${y.fields[z][0]}${s(y.fields[z][1])}${s(y.fields[z][2], 'DEFAULT ')}${s(y.fields[z][3])}`))
      }
  );

  //fields
  Object.keys(def.fields).forEach(z => lines.push(`${z} ${def.fields[z][0]}${s(def.fields[z][1])}${s(def.fields[z][2], 'DEFAULT ')}${s(def.fields[z][3])}`));

  //belongs
  def.belongs_to.forEach(y => {
    const res = parseFK(y);
    const table = res.table;
    const fk = res.fk;

    lines.push(`${fk} INTEGER NOT NULL`);
    onDeletes.push(`FOREIGN KEY (${fk}) REFERENCES ${table} (id) ON DELETE CASCADE`);
  });

  //associate
  def.associate_to.forEach(y =>{
    const res = parseFK(y);
    const table = res.table;
    const fk = res.fk;

    lines.push(`${fk} INTEGER`);
    onDeletes.push(`FOREIGN KEY (${fk}) REFERENCES ${table} (id) ON DELETE SET NULL`);
  });

  //belongs many
  const belongs_many = def.has_and_belongs_to_many.map(
      y => {
        const a = pluralize.singular(table);
        const b = pluralize.singular(snakeCase(Object.keys(y).join('')));
        const tbl =  a + '_' + pluralize.plural(b);

        return `CREATE TABLE ${tbl}(
${a}_id INTEGER NOT NULL,
${b}_id INTEGER NOT NULL,
weight REAL, 
FOREIGN KEY (${a}_id) REFERENCES ${pluralize.plural(a)} (id) ON DELETE CASCADE ,
FOREIGN KEY (${b}_id) REFERENCES ${pluralize.plural(b)} (id) ON DELETE CASCADE
);`;
      }).join('\n');

  return `CREATE TABLE ${table}(
${lines.concat(onDeletes).join(' ,\n')}
);

CREATE TRIGGER ${table}_updated_at AFTER UPDATE ON ${table} WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE ${table} SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;

${belongs_many}`;
}

function parseFK(model){
  const keys = Object.keys(model[Object.keys(model).join('')]);
  let table = '';
  let fk = '';

  if(
      keys.includes('extends') ||
      keys.includes('fields') ||
      keys.includes('belongs_to') ||
      keys.includes('associate_to') ||
      keys.includes('has_and_belongs_to_many')
  ){
    table = snakeCase(Object.keys(model).join(''));
    fk = pluralize.singular(table) + '_id';
  }else{
    table = snakeCase(keys.join(''));
    fk = pluralize.singular(snakeCase(Object.keys(model).join(''))) + '_id';
  }

  return {table: table, fk: fk};
}

function getDef(model){
  const key = Object.keys(model).join('');

  return Object.assign({
    extends:[],
    fields:{},
    belongs_to: [],
    associate_to :[],
    has_and_belongs_to_many : []
  }, model[key]);
}

const main = function(schema){
  if(!validateSchema(schema)){
    throw new Error('Invalid Schema');
  }
  return schema.map( model => parse(model)).join('\n')
};

const insert = function(data){
  const lines = [];

  data.forEach(x => {
    const table = snakeCase(Object.keys(x[0]).join(''));
    const keys = Object.keys(x[1][0]);
    lines.push(
        `INSERT INTO ${table} (${keys.join(', ')}) VALUES ${ x[1].map( y => `(${Object.keys(y).map(z => `'${String(y[z]).replace(/'/g, "''")}'`).join(', ')})`).join(',\n')};`
    );
  });

  return lines.join('\n');
};

module.exports = {
  parse : main,
  insert : insert
};