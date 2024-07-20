#!/usr/bin/env bash

set -e

route_traffic() {
    echo "Routing traffic to $1"
    
    case $1 in
        "a")
            upstreams='[{"dial":"zerodowndeploy-a:8000"}]'
        ;;
        "b")
            upstreams='[{"dial":"zerodowndeploy-b:8000"}]'
        ;;
        "ab")
            upstreams='[{"dial":"zerodowndeploy-a:8000"},{"dial":"zerodowndeploy-b:8000"}]'
        ;;
    esac
    
    docker compose exec caddy curl \
        -H "Content-Type: application/json" \
        -d "$upstreams" \
        -X PATCH http://localhost:2019/config/apps/http/servers/srv0/routes/0/handle/0/upstreams
}

restart() {
    echo "Restarting $1"
    container=zerodowndeploy-$1
    docker compose down "$container"
    docker compose up -d "$container"
}

wait_healthy() {
    echo "Waiting for $1 to be healthy"
    container=zerodowndeploy-$1
        
    if docker compose exec "$container" \
        curl -I --retry 30 --retry-max-time 0 --retry-all-errors --fail-with-body http://localhost:8000/health
    then
        echo "$1 is healthy"
    else
        echo "$1 failed to start!"
        exit 1
    fi
}

route_traffic b
sleep 10

restart a
wait_healthy a
route_traffic a
sleep 10

restart b
wait_healthy b
route_traffic ab
