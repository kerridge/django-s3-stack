# !/bin/bash

GITHUB_REPOSITORY_NAME=$1

# Change working directory
ROOT_DIR="/home/docker/"
WORK_DIR="$ROOT_DIR/$GITHUB_REPOSITORY_NAME"
PRODUCTION_DOCKER_COMPOSE_FILE="docker-compose.server.yml"

cd $WORK_DIR

# docker login

docker-compose -f $PRODUCTION_DOCKER_COMPOSE_FILE pull app

docker-compose -f $PRODUCTION_DOCKER_COMPOSE_FILE up --detach

# # Health check new containers
#     # if healthy
#     exit 0

#     # elif unhealthy
#     exit 1