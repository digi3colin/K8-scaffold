const fs = require('fs');
const pluralize = require('pluralize');
const camelCase = require('camelcase');
const Database  = require('better-sqlite3');
const db = new Database('.db/db.sqlite');
const tables = db.prepare(`SELECT name FROM sqlite_master WHERE type='table'`).all();

const capitalize = (str)=> {
  return str.charAt(0).toUpperCase() + str.slice(1);
};

const classes = [];
tables.forEach(x => {
  if(x.name === 'sqlite_sequence')return;

  const columns = db.prepare(`PRAGMA table_info(${x.name})`)
    .all()
    .map(y => y.name);

  const isORM = columns.includes('created_at');
  if(isORM){
    const tableName = x.name;
    const className = capitalize(pluralize.singular(x.name));
    const belongs = [];
    columns.forEach(x => {
      if(/_id$/.test(x)){
        belongs.push(capitalize(x.replace('_id', '')));
      }
    });

    classes[className] = {
      'modelName': className,
      'tableName': tableName,
      'properties': columns,
      'belongs' : belongs,
      'hasMany' : []
    }
  }else{
    const a = x.name.split('_')[0];
    const b = x.name.replace(a+'_', '');

    classes[capitalize(a)]
      .hasMany
      .push(capitalize(pluralize.singular(b)));
  }
});

// models
Object.keys(classes).forEach(key => {
  const x = classes[key];
  const fileName = `./exports/model/${x.modelName}.js`;
  const relations = [].concat(x.belongs).concat(x.hasMany);

  //parse properties
  let props = `    this.tableName = '${x.tableName}';\n`;
  x.properties.forEach(y => {
    if(y === 'id' || y === 'created_at' || y === 'updated_at'){
      return;
    }

    props += `    this.${y} = null;\n`;
  });

  //parse header
  let header = '';
  header += `const K8 = require('k8mvc');\n`;
  header += `const ORM = K8.require('ORM');\n`;

  relations.forEach(x => {
    header += `const ${x} = K8.require('model/${x}');\n`;
  });

  //methods
  let methods = ``;
  x.belongs.forEach(y => {
    methods += `  get${camelCase(y,{pascalCase: true})}(){return this.belongsTo(${y});}\n\n`;
  });

  x.hasMany.forEach(y => {
    const throughTable = `${x.modelName}_${pluralize.plural(y)}`.toLowerCase();
    methods += `  get${camelCase(pluralize.plural(y),{pascalCase: true})}(){return this.hasManyThrough(${y}, '${throughTable}');}\n\n`;
  });

//combine the content
const text =
`${header}
class ${x.modelName} extends ORM{
  constructor(props) {
    super(props);

${props}
  }

${methods}
}

${x.modelName}.name = '${x.modelName}';
${x.modelName}.tableName = '${x.tableName}';
module.exports = ${x.modelName};
`;

  //write;
  fs.writeFile(fileName, text, err => {if(err)console.log(err);});
});

//controllers
Object.keys(classes).forEach(key => {
  const x = classes[key];
  const fileName = `./exports/controller/Controller${x.modelName}.js`;

  //parse header
  let header = '';
  header += `const K8 = require('k8mvc');\n`;
  header += `const Controller = K8.require('Controller');\n`;
  header += `const ${x.modelName} = K8.require('model/${x.modelName}');`;

//combine the content
  const text =
    `${header}

class Controller${x.modelName} extends Controller{
  constructor(request, response) {
    super(request, response);
    this.model = ${x.modelName};
  }
}

module.exports = Controller${x.modelName};
`;

  //write;
  fs.writeFile(fileName, text, err => {if(err)console.log(err);});
});

// admin controllers
Object.keys(classes).forEach(key => {
  const x = classes[key];
  const fileName = `./exports/controller/admin/ControllerAdmin${x.modelName}.js`;

  //parse header
  let header = '';
  header += `const K8 = require('k8mvc');\n`;
  header += `const ControllerAdmin = K8.require('ControllerAdmin');\n`;
  header += `const ${x.modelName} = K8.require('model/${x.modelName}');`;

  //methods
  let methods = ``;

//combine the content
  const text =
`${header}

class ControllerAdmin${x.modelName} extends ControllerAdmin{
  constructor(request, response) {
    super(request, response);
    this.model = ${x.modelName};
  }
}

module.exports = ControllerAdmin${x.modelName};
`;

  //write;
  fs.writeFile(fileName, text, err => {if(err)console.log(err);});
});