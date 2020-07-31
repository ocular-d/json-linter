FROM node:lts-alpine3.12
LABEL maintainer="ocular-d <sven@ocular-d.tech>" \
org.label-schema.vendor="ocular-d" \
    com.github.actions.name="JSON Lint Action" \
    com.github.actions.description="Validate JSON files with jsonlint." \
    com.github.actions.icon="truck" \
    com.github.actions.color="blue"

ENV npm_config_loglevel=silent

# hadolint ignore=DL3018
RUN apk add --no-cache \
        bash \
		fd

RUN npm install -g jsonlint@1.6.3 && \
	rm -rf ~/.npm

WORKDIR /test

COPY entrypoint.sh /test/entrypoint.sh

#RUN chown -R node:node /test

RUN chmod +x /test/entrypoint.sh

#WORKDIR /test

#ENTRYPOINT ["bash"]
ENTRYPOINT ["/test/entrypoint.sh"]

#USER node
