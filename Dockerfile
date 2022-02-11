FROM node:lts-alpine3.15
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

# Test with https://github.com/circlecell/jsonlint-mod
RUN npm install -g jsonlint-mod@1.7.6 && \
	npm cache clean --force

USER node
WORKDIR /home/node

COPY --chown=node:node entrypoint.sh /code/
RUN chmod u+x /code/entrypoint.sh



#ENTRYPOINT ["bash"]
#ENTRYPOINT ["/test/entrypoint.sh"]
ENTRYPOINT ["/code/entrypoint.sh"]
CMD []
