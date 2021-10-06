# !/bin/bash

# Change working directory
ROOT_DIR="/home/docker/"
WORK_DIR="$ROOT_DIR/$GITHUB_REPOSITORY_NAME"
PRODUCTION_DOCKER_COMPOSE_FILE="docker-compose.server.yml"

cd $WORK_DIR

# docker login

docker-compose -f $PRODUCTION_DOCKER_COMPOSE_FILE pull app

# TODO: this is a tightly coupled approach, look at using an env file
# if [ -e .env.docker ]; then
#     echo "exists"
# else

# rm .env.docker
# touch .env.docker
# echo "AWS_STORAGE_BUCKET_NAME=$AWS_STORAGE_BUCKET_NAME" >> .env.docker
# echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> .env.docker
# echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> .env.docker
# echo "AWS_S3_REGION_NAME=$AWS_S3_REGION_NAME" >> .env.docker
cat .env.api
# echo "BUCKET: $AWS_STORAGE_BUCKET_NAME"
# echo "REGION: $AWS_S3_REGION_NAME"

# AWS_STORAGE_BUCKET_NAME="$AWS_STORAGE_BUCKET_NAME" \
# AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
# AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
# AWS_S3_REGION_NAME="$AWS_S3_REGION_NAME" \
docker-compose \
    -f $PRODUCTION_DOCKER_COMPOSE_FILE \
    up --detach

    # -e AWS_STORAGE_BUCKET_NAME=$AWS_STORAGE_BUCKET_NAME \
    # -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    # -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    # -e AWS_S3_REGION_NAME=$AWS_S3_REGION_NAME \

    # -e SQL_ENGINE=$SQL_ENGINE
    # -e DATABASE=$DATABASE \
    # -e SQL_DATABASE=$SQL_DATABASE \
    # -e SQL_USER=$SQL_USER \
    # -e SQL_PASSWORD=$SQL_PASSWORD \
    # -e SQL_HOST=$SQL_HOST \
    # -e SQL_PORT=$SQL_PORT \
    # -e DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE \
    # -e DJANGO_ALLOWED_HOSTS=$DJANGO_ALLOWED_HOSTS \
    # -e SECRET_KEY=$SECRET_KEY \
    # -e DEBUG=$DEBUG \

# # Health check new containers
#     # if healthy
#     exit 0

#     # elif unhealthy
#     exit 1