#!/bin/bash
CWD=`cd $(dirname $0); pwd`

mkdir asapp-project-challenge
cd asapp-project-challenge
npm init -y
git init
node $CWD/package.js "$*"