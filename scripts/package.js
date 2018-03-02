var fs = require('fs');
var path = require('path');
var pk = require(path.join(process.cwd(), 'package.json'));

var args = Array.prototype.slice.call(process.argv, 2)
var name = args.shift().toLowerCase().replace(/\s/g, '-');
var author = args.shift();
var tags = args;

pk.name = name
pk.scripts.package = 'tar --exclude asapp-project-challenge.tgz --exclude node_modules -czf asapp-project-challenge.tgz *';
pk.author = author;
pk.tags = tags;

fs.writeFileSync('./package.json', JSON.stringify(pk, null, 4), { encoding: 'utf-8' });