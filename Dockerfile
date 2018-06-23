FROM docker:stable

RUN apk add --update git nodejs nodejs-npm \
    && npm install -g npm && npm install -g yarn

WORKDIR /usr/src/app
COPY ./package.json ./yarn.lock /usr/src/app/
RUN yarn install

COPY . /usr/src/app

EXPOSE 80

CMD SECERT=$SECERT \
    REPO_URL=$REPO_URL \
    BRANCH=$BRANCH \
    TAG=$TAG \
    yarn start
