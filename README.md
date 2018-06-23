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

### Node

```bash
npm install -g yarn
cd <directory of this readme>
yarn install
```

## Preparaction

```bash
cd <directory of this readme>
mkdir refs
git clone -b <branch> --single-branch <git://sub.domain.com/repo.git> repo
```

## Example

```bash
SECERT='secert-key' \
REPO_URL='https://github.com/emj365/prepsmith' \
BRANCH='staging' \
TAG='emj365/prepsmith:latest' \
yarn start
```
