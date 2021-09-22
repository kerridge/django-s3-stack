#!/bin/bash

# Shows the usage for the script.
showUsage () {
    echo "Description:"
    echo "    Builds, runs and pushes Docker image '$IMAGE_NAME'."
    echo ""
    echo "Options:"
    echo "    build: Builds a Docker image ('$IMAGE_NAME')."
    echo "    run: Runs a container based on an existing Docker image ('$IMAGE_NAME')."
    echo "    buildrun: Builds a Docker image and runs the container."
    echo "    push: Pushs the image '$IMAGE_NAME' to an image repository"
    echo ""
    echo "Example:"
    echo "    ./docker-task.sh --prod build"
    echo "    ./docker-task.sh --dev build"
    echo ""
    echo "    This will:"
    echo "        Build a Docker image named $IMAGE_NAME."
}

# Variables
PRODUCTION_DOCKER_COMPOSE_FILE="docker-compose.server.yml"

IMAGE_NAME="winterwindsoftware/simple-express-app"
CONTAINER_NAME="simple-express-app_dev"
REPOSITORY_PATH="856405715088.dkr.ecr.us-east-1.amazonaws.com" #TODO: set this to the path of your ECS repository
FULLY_QUALIFIED_IMAGE_NAME="$REPOSITORY_PATH/$IMAGE_NAME"
HOST_PORT=80
CONTAINER_PORT=80

# Set environment target
case "$1" in
    -p|--prod)
        echo "-------------------------------------------------------------"
        echo "------------ Production Docker Configuration ----------------"
        echo "-------------------------------------------------------------"
        ENVIRONMENT="prod"
    ;;
    -d|--dev)
        echo "-------------------------------------------------------------"
        echo "------------ Development Docker Configuration ----------------"
        echo "-------------------------------------------------------------"
        ENVIRONMENT="dev"
    ;;
    *)
        showUsage
        exit 1
    ;;
esac

# Builds the Docker image and tags it with latest version number.
buildImage () {
    echo Building Image Version: $IMAGE_VERSION ...
    docker build -t $IMAGE_NAME:latest -t $IMAGE_NAME:$IMAGE_VERSION ./
    echo Build complete.
}

# Runs the container locally.
runContainer () {
    docker run --rm \
        --name $CONTAINER_NAME \
        -p $HOST_PORT:$CONTAINER_PORT \
        -e "NODE_ENV=development" \
        -d $IMAGE_NAME
    echo Container started. Open browser at http://localhost:$HOST_PORT .

    docker run --rm \
        --port 5010:80 -d \
        --name django_s3_stack \
        --env-file .env.prod \
        django_s3_stack
}

# Pushes the latest version of the image both with the `latest` and specific version tags
pushImage () {
    docker tag $IMAGE_NAME:latest $FULLY_QUALIFIED_IMAGE_NAME:latest
    docker tag $IMAGE_NAME:$IMAGE_VERSION $FULLY_QUALIFIED_IMAGE_NAME:$IMAGE_VERSION
    eval "$(aws ecr get-login --no-include-email --region $AWS_REGION)"
    docker push $FULLY_QUALIFIED_IMAGE_NAME:latest
    docker push $FULLY_QUALIFIED_IMAGE_NAME:$IMAGE_VERSION
}


# -------------------------------------------------------------
# ----------------------- PRODUCTION --------------------------
# -------------------------------------------------------------
buildProductionImage () {
    docker-compose -f $PRODUCTION_DOCKER_COMPOSE_FILE build app
}

# runs production Docker container in detached mode
runProductionContainer () {
    docker-compose -f $PRODUCTION_DOCKER_COMPOSE_FILE up --detach app
}

# stops all running docker-compose containers
stopProductionContainer () {
    docker-compose -f $PRODUCTION_DOCKER_COMPOSE_FILE stop app
}

followProductionLogs () {
    docker-compose logs --follow app
    # while true;
    # do 
    # done & sleep 60 ; kill $!
}



if [ $# -eq 0 ]; then
  showUsage
else
    if [[ $ENVIRONMENT == "dev" ]]; then
        case "$2" in
            "build")
                buildImage;;
            "run")
                runContainer;;
            "buildpush")
                buildImage
                pushImage;;
            "push")
                pushImage;;
            "buildrun")
                buildImage
                runContainer;;
            *)
                showUsage;;
        esac
    elif [[ $ENVIRONMENT == "prod" ]]; then
        case "$2" in
            "build")
                buildProductionImage;;
            "run")
                runProductionContainer;;
            "buildrun")
                buildProductionImage
                runProductionContainer;;
            "logs")
                followProductionLogs;;
            "stop")
                stopProductionContainer;;
            "update")
                stopProductionContainer
                runProductionContainer;;
            *)
                showUsage;;
        esac
    fi
fi