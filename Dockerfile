FROM docker.io/klakegg/hugo:ext AS hugo

WORKDIR /src
COPY . /src
RUN hugo --gc --minify -e PRODUCTION -d /target

FROM docker.io/caddy

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=hugo /target /usr/share/caddy/
