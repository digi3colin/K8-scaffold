const VERSION = '0.1.20';
const fs = require('fs');

const pluralize = require('pluralize');
const snakeCase = require('snake-case');

function convertDefaultValue(value){
  if(!value)return 'null';
  if(isNaN(parseFloat(value)))return `'${value}'`;
  return value;
}

function parseClass(model){
  return `const K8 = require('k8mvc');
const ORM = K8.require('ORM');

class ${model.className} extends ORM{
  constructor(key, options) {
    super(key, options);
    if(key)return;

    //foreignKeys
${model.foreignKeys.map(x => `    this.${x} = null;`).join('\n')}

    //fields
${model.fields.map(x => `    this.${x} = ${model.defaultValues[x]};`).join('\n')}
  }
}

${model.className}.jointTablePrefix = '${pluralize.singular(model.tableName)}';
${model.className}.tableName = '${model.tableName}';
${model.className}.key       = '${model.key}';

${model.className}.fieldType = {
  ${Object.keys(model.fieldType).map(x => `${x} : [${model.fieldType[x].map(y => `'${y}'`).join(', ')}]`).join(',\n  ')}
};

${model.className}.belongsTo = [
  ${model.belongsTo.map(x => (typeof x === 'object') ? x : ({model:x, fk:`${snakeCase(x)}_id`})).map( x => `{fk: '${x.fk}', model: '${x.model}'}`).join(',\n  ')}
];

${model.className}.hasMany   = [
  ${model.hasMany.map(  x => (typeof x === 'object') ? x : ({model:x, fk:`${snakeCase(model.className)}_id`})).map( x => `{fk: '${x.fk}', model: '${x.model}'}`).join(',\n  ')}
];

${model.className}.belongsToMany = [
  ${model.belongsToMany.map(x => `'${x}'`).join(',\n  ')}
];


module.exports = ${model.className};
`;
}

function parseController(model){
  return `const K8 = require('k8mvc');
const ControllerORMView = K8.require('ControllerORMView');
const ${model.className} = K8.require('models/${model.className}');

class Controller${model.className} extends ControllerORMView{
  constructor(request, response) {
    super(request, response);
    this.model = ${model.className};
  }
}

module.exports = Controller${model.className};
`;
}

function parseControllerAdmin(model){
  return `const K8 = require('k8mvc');
const ControllerAdmin = K8.require('ControllerAdmin');
const ${model.className} = K8.require('models/${model.className}');

class ControllerAdmin${model.className} extends ControllerAdmin{
  constructor(request, response) {
    super(request, response);
    this.model = ${model.className};
  }
}

module.exports = ControllerAdmin${model.className};
`;
}

function parseFK(model){
  const keys = Object.keys(model[Object.keys(model).join('')]);
  let table = '';
  let fk = '';
  let className = '';

  if(
    keys.includes('extends') ||
    keys.includes('fields') ||
    keys.includes('belongs_to') ||
    keys.includes('associate_to') ||
    keys.includes('has_and_belongs_to_many')
  ){
    const key = Object.keys(model).join('');
    className = pluralize.singular(key);
    table = snakeCase(key);
    fk = pluralize.singular(table) + '_id';
  }else{
    const key = Object.keys(model).join('');
    className = pluralize.singular(keys.join(''));
    table = snakeCase(keys.join(''));
    fk = pluralize.singular(snakeCase(key)) + '_id';
  }

  return {className : className, table: table, fk: fk};
}

const CONV_CLASS = 'CONV_CLASS';
const CONV_KEY   = 'CONV_KEY';
const CONV_TABLE = 'CONV_TABLE';

function conversion(model, type){
  const key       = Object.keys(model).join('');

  switch (type) {
    case CONV_CLASS:
      return pluralize.singular(key);
    case CONV_KEY:
      return snakeCase(pluralize.singular(key))+'_id';
    case CONV_TABLE:
      return snakeCase(key);
    default:
      throw new Error('Conversion Type cannot be null');
  }
}

function getDef(model){
  const key       = Object.keys(model).join('');
  const rawDef    = model[key];

  const def = {
    className : conversion(model, CONV_CLASS),
    tableName : conversion(model, CONV_TABLE),
    key       : conversion(model, CONV_KEY),
    fields    :[],
    defaultValues : {},
    fieldType :{},

    foreignKeys   : [],
    belongsTo     : [],
    belongsToMany : [],
    hasMany       : [],
  };

  //parse extends
  (rawDef.extends || []).forEach( x => {
    Object.keys(x.fields).forEach(y => {
      def.fields.push(y);
      def.fieldType[y] = x.fields[y];

      def.defaultValues[y] = convertDefaultValue(x.fields[y][2]);
    });
  });

  //parse fields
  Object.keys(rawDef.fields || {}).forEach( y => {
    def.fields.push(y);
    def.fieldType[y] = rawDef.fields[y];

    def.defaultValues[y] = convertDefaultValue(rawDef.fields[y][2]);
  });

  //parse fk
  (rawDef.belongs_to || []).forEach( x => {
    const res = parseFK(x);

    def.belongsTo.push(
      (`${snakeCase(res.className)}_id` === res.fk)?
      res.className :
      {model:res.className, fk: res.fk}
    );
    def.foreignKeys.push(res.fk);
  });

  (rawDef.associate_to || []).forEach( x => {
    const res = parseFK(x);
    def.belongsTo.push(
      (`${snakeCase(res.className)}_id` === res.fk)?
        res.className :
        {model:res.className, fk: res.fk}
    );
    def.foreignKeys.push(res.fk);
  });

  //parse belongsToMany
  (rawDef.has_and_belongs_to_many || []).forEach( x => {
    const res = parseFK(x);
    def.belongsToMany.push(res.className);
  });

  return def;
}

const addHasMany = schema => {
  const d = schema.map(model => getDef(model));

  const indexByClassName = {};
  d.forEach(x => {
    indexByClassName[x.className] = x;
  });

  d.forEach( x => {
    x.belongsTo.forEach(y => {
      if(typeof y === 'string'){
        indexByClassName[y].hasMany.push(x.className);
      }else{
        indexByClassName[y.model].hasMany.push({
          model: x.className,
          fk: y.fk,
        });
      }
    });
  });

  return d;
};

module.exports = {
  exec : (schema, path) => {
    const rimraf = require("rimraf");
    rimraf.sync(path);

    if (!fs.existsSync(`${path}`)){
      fs.mkdirSync(`${path}`);
      fs.mkdirSync(`${path}/models`);
      fs.mkdirSync(`${path}/controllers`);
      fs.mkdirSync(`${path}/controllers/admin`);
    }

    addHasMany(schema).forEach(x => {
      const codeClass = parseClass(x);
      const codeController = parseController(x);
      const codeControllerAdmin = parseControllerAdmin(x);

      fs.writeFile(`${path}/models/${x.className}.js`, codeClass, err => {if(err)console.log(err);});
      fs.writeFile(`${path}/controllers/Controller${x.className}.js`, codeController, err => {if(err)console.log(err);});
      fs.writeFile(`${path}/controllers/admin/ControllerAdmin${x.className}.js`, codeControllerAdmin, err => {if(err)console.log(err);});
    })
  }
};