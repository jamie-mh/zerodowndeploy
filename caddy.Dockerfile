FROM caddy:2.8-alpine

RUN apk --no-cache add curl

COPY Caddyfile /etc/caddy/Caddyfile
