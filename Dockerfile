FROM docker:stable

RUN apk add --update git nodejs nodejs-npm openssh-client && \
    npm install -g npm && npm install -g yarn

WORKDIR /usr/src/app
COPY ./package.json ./yarn.lock /usr/src/app/
RUN yarn install

COPY . /usr/src/app
RUN mkdir /usr/src/app/refs

EXPOSE 80

RUN mkdir /root/.ssh
CMD cp /run/secrets/prepsmith-repo-key /root/.ssh/id_rsa && \
    chmod 400 /root/.ssh/id_rsa && \
    ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts && \
    git clone -b $BRANCH --single-branch $REPO_SSH_URL repo && \
    SECERT=$SECERT \
    REPO_URL=$REPO_URL \
    BRANCH=$BRANCH \
    TAG=$TAG \
    yarn start
