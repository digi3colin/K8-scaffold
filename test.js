const fs = require('fs');
const pluralize = require('pluralize');
const camelCase = require('camelcase');
const capitalize = require('capitalize');
const Database  = require('better-sqlite3');
const db = new Database('./db/db.sqlite');
const tables = db.prepare(`SELECT name FROM sqlite_master WHERE type = 'table' AND name <> 'sqlite_sequence'`).all();

const classes = [];
tables.forEach(x => {
  const tableName = x.name;

  const columns = db.prepare(`PRAGMA table_info(${tableName})`)
    .all()
    .map(y => y.name);

  const isORM = columns.includes('created_at');

  if(isORM){
    const className = capitalize(pluralize.singular(tableName));
    const properties = [];
    const belongs = [];

    columns.forEach( column => {
      if(column === 'id' || column === 'created_at' || column === 'updated_at'){
        return;
      }

      if(/_id$/.test(column)){
        const a = className;
        const b = capitalize(column.replace('_id', ''));

        belongs.push(b);

        classes[b] = classes[b] || {};
        classes[b].hasMany = classes[b].hasMany || [];
        classes[b].hasMany.push(a);
      }else{
        properties.push(column);
      }
    });

    classes[className] = Object.assign( (classes[className] || {}) , {
      'tableName': tableName,
      'properties': properties,
      'belongs' : belongs,
    });

  }else{
    let a = x.name.split('_')[0];
    const b = capitalize(pluralize.singular(x.name.replace(a+'_', '')));
    a = capitalize(a);

    classes[a] = classes[a] || {};
    classes[a].belongsToMany = classes[a].belongsToMany || [];
    classes[a].belongsToMany.push(b);

  }

});

//code gen
// models
Object.keys(classes).forEach(key => {
  const x = classes[key];
  const fileName = `./exports/classes/model/${key}.js`;
  const relations = [].concat(x.belongs).concat(x.hasMany);

  const belongs = x.belongs || [];
  const hasMany = x.hasMany || [];
  const belongsToMany = x.belongsToMany || [];
  const properties = x.properties || [];


  belongs.forEach( y => {
    if(!relations.includes(y)) relations.push(y);
  });

  hasMany.forEach( y => {
    if(!relations.includes(y)) relations.push(y);
  });

  belongsToMany.forEach( y => {
    if(!relations.includes(y)) relations.push(y);
  });

  //parse header
  let header = '';
  header += `const K8 = require('k8mvc');\n`;
  header += `const ORM = K8.require('ORM');\n`;

  relations.forEach(x => {
    if(x === undefined)return;
    header += `const ${x} = K8.require('model/${x}');\n`;
  });

//combine the content
  const text =
    `${header}
class ${key} extends ORM{
  constructor() {
    super();

${properties.map(y => `    this.${y} = null;`).join('\n')}
  }
}

${key}.tableName     = '${x.tableName}';
${key}.fields        = [${properties.map(x => `'${x}'`).join(', ')}];
${key}.belongsTo     = [${belongs.join(', ')}];
${key}.hasMany       = [${hasMany.join(', ')}];
${key}.belongsToMany = [${belongsToMany.join(', ')}];
${key}.key           = '${key.toLowerCase()}_id';
${key}.lowercase     = '${key.toLowerCase()}';

module.exports = ${key};
`;
if(x.tableName === undefined)return;
  //write;
  fs.writeFile(fileName, text, err => {if(err)console.log(err);});
});

//controllers
Object.keys(classes).forEach(key => {
  const x = classes[key];
  const fileName = `./exports/classes/controller/Controller${key}.js`;

  //parse header
  let header = '';
  header += `const K8 = require('k8mvc');\n`;
  header += `const ControllerWithView = K8.require('ControllerWithView');\n`;
  header += `const ${key} = K8.require('model/${key}');`;

//combine the content
  const text =
    `${header}

class Controller${key} extends ControllerWithView{
  constructor(request, response) {
    super(request, response);
    this.model = ${key};
  }
}

module.exports = Controller${key};
`;
  if(x.tableName === undefined)return;
  //write;
  fs.writeFile(fileName, text, err => {if(err)console.log(err);});
});

// admin controllers
Object.keys(classes).forEach(key => {
  const x = classes[key];
  const fileName = `./exports/classes/controller/admin/ControllerAdmin${key}.js`;

  //parse header
  let header = '';
  header += `const K8 = require('k8mvc');\n`;
  header += `const ControllerAdmin = K8.require('ControllerAdmin');\n`;
  header += `const ${key} = K8.require('model/${key}');`;

//combine the content
  const text =
    `${header}

class ControllerAdmin${key} extends ControllerAdmin{
  constructor(request, response) {
    super(request, response);
    this.model = ${key};
  }
}

module.exports = ControllerAdmin${key};
`;
  if(x.tableName === undefined)return;
  //write;
  fs.writeFile(fileName, text, err => {if(err)console.log(err);});
});