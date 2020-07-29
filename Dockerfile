FROM node:lts-alpine3.12
LABEL maintainer="ocular-d <sven@ocular-d.tech>"

ENV npm_config_loglevel=silent

WORKDIR /json

RUN npm install -g jsonlint@1.6.3 && \
	rm -rf ~/.npm && \
	jsonlint --help

USER node
