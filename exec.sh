#!/bin/sh

ts=$(date +%s)

cd repo
git fetch origin staging:refs/remotes/origin/staging
git checkout-index -a -f --prefix=../refs/$ts/
cd ../refs/$ts
docker build -t emj365/prepsmith:latest .
docker push emj365/prepsmith:latest

cd ../..
echo $ts >> log
