#!/bin/bash -e
CWD=`cd $(dirname $0); pwd`

STATELIB="$1"
STYLELIB="$2"
SERVER="$3"

[ -z `which create-react-app` ] && npm install -g create-react-app
create-react-app asapp-project-challenge --use-npm
cd asapp-project-challenge
git init

if [ "$STATELIB" == "Redux" ]; then
    npm install react-redux redux --save
    cp -R $CWD/files/react-redux/* .
elif [ "$STATELIB" == "MobX" ]; then
    npm install mobx-react mobx --save
    cp -R $CWD/files/react-mobx/* .
fi

if [ "$STYLELIB" == "SASS" ]; then
    npm install --save node-sass-chokidar npm-run-all
    node -e "\
    var fs = require('fs');\
    var pk = require('./package.json');\

    pk.scripts['build-css'] = 'node-sass-chokidar src/ -o src/';\
    pk.scripts['watch-css'] = 'npm run build-css && node-sass-chokidar src/ -o src/ --watch --recursive';\
    pk.scripts.start = 'npm-run-all -p watch-css start-js';\
    pk.scripts['start-js'] = 'react-scripts start';\
    pk.scripts.build = 'npm-run-all build-css build-js';\
    pk.scripts['build-js'] = 'react-scripts build';\
    fs.writeFileSync('./package.json', JSON.stringify(pk, null, 4), { encoding: 'utf-8' });"
    mv src/App.css src/App.scss

elif [ "$STYLELIB" == "LESS" ];then
    npm install --save node-less-chokidar npm-run-all

    node -e "\
    var fs = require('fs');\
    var pk = require('./package.json');\

    pk.scripts['build-css'] = 'node-less-chokidar src/ -o src/';\
    pk.scripts['watch-css'] = 'npm run build-css && node-less-chokidar src/ -o src/ --watch --recursive';\
    pk.scripts.start = 'npm-run-all -p watch-css start-js';\
    pk.scripts['start-js'] = 'react-scripts start';\
    pk.scripts.build = 'npm-run-all build-css build-js';\
    pk.scripts['build-js'] = 'react-scripts build';\
    fs.writeFileSync('./package.json', JSON.stringify(pk, null, 4), { encoding: 'utf-8' });"
    mv src/App.css src/App.less
fi

# if [ $SERVER == "Node" ]; then
#     npm install --save express isomorphic-fetch npm-run-all
#     cp -R $CWD/files/node/* .

#     node -e "\
#     var fs = require('fs');\
#     var pk = require('./package.json');\

#     pk.scripts.start = 'npm-run-all -p watch-css start-js';\
#     pk.scripts['start-server'] = 'react-scripts start';\
#     pk.scripts.build = 'npm-run-all build-css build-js';\
#     pk.scripts['build-js'] = 'react-scripts build';\
#     fs.writeFileSync('./package.json', JSON.stringify(pk, null, 4), { encoding: 'utf-8' });"

# fi