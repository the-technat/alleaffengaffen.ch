FROM docker.io/klakegg/hugo:ext AS hugo

WORKDIR /src
COPY . /src
RUN hugo --gc --minify -e PRODUCTION -d /target

FROM docker.io/caddy:2

LABEL org.opencontainers.image.source = "https://github.com/alleaffengaffen/alleaffengaffen"
LABEL org.opencontainers.image.version = "main"
LABEL org.opencontainers.image.description = "Alle Affen Gaffen Webapp"
LABEL org.opencontainers.image.title = "alleaffengaffen"
LABEL org.opencontainers.image.url = "https://github.com/alleaffengaffen/alleaffengaffen"
LABEL org.opencontainers.image.vendor = "alleaffengaffen"
LABEL org.opencontainers.image.authors = "the-technat"
LABEL org.opencontainers.image.base.name = "docker.io/caddy:latest"

# Those are the files the app needs (all owned by root, arbitrary users can read/execute):
RUN chown root:root /usr/bin/caddy
COPY --chown=root:root Caddyfile /etc/caddy/Caddyfile
COPY --chown=root:root --from=hugo /target /usr/share/caddy/

# Any UID will do it, this is just the default if you omit it
USER 10000
