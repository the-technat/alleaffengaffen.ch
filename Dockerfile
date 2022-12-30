FROM docker.io/klakegg/hugo:ext AS hugo

WORKDIR /src
COPY . /src
RUN hugo --gc --minify -e PRODUCTION -d /target

FROM docker.io/caddy

LABEL org.opencontainers.image.source = "https://github.com/alleaffengaffen/alleaffengaffen"

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=hugo /target /usr/share/caddy/
