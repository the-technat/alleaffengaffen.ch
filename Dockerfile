FROM docker.io/klakegg/hugo:ext AS hugo

WORKDIR /src
COPY . /src
RUN hugo --gc --minify -e PRODUCTION -d /target

FROM docker.io/caddy:latest

LABEL org.opencontainers.image.source = "https://github.com/alleaffengaffen/alleaffengaffen"
LABEL org.opencontainers.image.version = "main"
LABEL org.opencontainers.image.description = "Alle Affen Gaffen Webapp"
LABEL org.opencontainers.image.title = "alleaffengaffen"
LABEL org.opencontainers.image.url = "https://github.com/alleaffengaffen/alleaffengaffen"
LABEL org.opencontainers.image.vendor = "alleaffengaffen"
LABEL org.opencontainers.image.authors = "the-technat"
LABEL org.opencontainers.image.base.name = "docker.io/caddy:latest"

USER 10000

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=hugo /target /usr/share/caddy/
