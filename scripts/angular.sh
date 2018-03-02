#!/bin/bash -e
CWD=`cd $(dirname $0); pwd`

[ -z `which ng` ] && npm install -g @angular/cli
ng new asapp-project-challenge
cd asapp-project-challenge
git init
node $CWD/package.js "$*"