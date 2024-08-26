#!/bin/bash
echo "Starting traefik with first positional argument as password for basic auth..."

export USERNAME=admin
export PASSWORD=$1

# Create a network if it doesn't exist
docker network inspecttraefik-public >/dev/null 2>&1 || \
    docker network create traefik-public

export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)

docker compose -f docker-compose.traefik.yml up -d