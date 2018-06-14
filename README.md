# Docker Building Webhook

A webhook handeler build on ExpressJS to build docker image when the Github branch pushed.

When branch pushed it will:

* fetch git branch
* check & pull updated image
* build image
* push image

## Dependencies

### System

* git
* docker
* node
* pm2

### NodeJS

```
npm install -g yarn
cd <directory of this readme>
yarn install
```

## Example

```bash
SECERT='secert-key' \
REPO_URL='https://github.com/emj365/prepsmith' \
BRANCH='staging' \
TAG='emj365/prepsmith:latest' \
yarn start
```
