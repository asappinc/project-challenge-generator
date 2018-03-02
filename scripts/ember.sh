#!/bin/bash -e
CWD=`cd $(dirname $0); pwd`

[ -z `which ember` ] && npm install -g ember-cli
ember new asapp-project-challenge
cd asapp-project-challenge
node $CWD/package.js "$*"