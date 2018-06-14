#!/bin/sh

branch=$BRANCH
tag=$TAG
ts=$(date +%s)

cd repo
git fetch origin $branch:refs/remotes/origin/$branch
mkdir ../refs/$ts
git --work-tree=$(pwd)/../refs/$ts checkout origin/$branch -- .
echo "fetched: $ts $branch"

cd ../refs/$ts
docker pull $tag # check update before build
docker build -t $tag .
echo "built: $ts $branch $tag"

cd ../..
rm -rf refs/$ts

docker push $tag
echo "pushed: $ts $branch $tag"
