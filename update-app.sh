# !/bin/bash

GITHUB_REPOSITORY_NAME=$1

echo "YEW: $GITHUB_REPOSITORY_NAME"

# Change working directory
ROOT_DIR="/home/docker/"
WORK_DIR="$ROOT_DIR/$GITHUB_REPOSITORY_NAME"

cd $WORK_DIR

# docker login
pwd

# Pull latest repo changes in case our scripts updated
git pull origin main

# # Stop currently running containers
# ./docker-tasks.sh --prod stop

# Start and Pull new containers
./docker-tasks.sh --prod run
# Follow container logs
./docker-tasks.sh --prod logs

# # Health check new containers
#     # if healthy
#     exit 0

#     # elif unhealthy
#     exit 1