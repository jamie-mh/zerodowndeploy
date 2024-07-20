FROM caddy:2.8-alpine
LABEL org.opencontainers.image.source=https://github.com/jamie-mh/zerodowndeploy

RUN apk --no-cache add curl

COPY Caddyfile /etc/caddy/Caddyfile
