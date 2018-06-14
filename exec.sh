#!/bin/sh

branch=$BRANCH
tag=$TAG
ts=$(date +%s)

cd repo
git fetch origin $BRANCH:refs/remotes/origin/$BRANCH
git checkout-index -a -f --prefix=../refs/$ts/
echo "built: $ts $branch $tag"

cd ../refs/$ts
docker pull $tag # check update before build
docker build -t $tag .

cd ../..
rm -rf refs/$ts

docker push $tag
echo "pushed: $ts $branch $tag"
