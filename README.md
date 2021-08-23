# django-s3-stack
https://excalidraw.com/#json=5671731079413760,Vi7BYErCS7GbfuSr37uaFw

https://excalidraw.com/#json=5423642091454464,gxzMZ1UnjIQakdN9Mgim2g


## Developer setup

### You will need
- Docker
- VS Code

### Build and run project
From the root directory run:
`docker-compose up --build`

This will build the Docker image and launch a new instance. After that the development server will wait for the VS Code debugger to be attached.

Your api should now be available at `localhost:5010`

To take the image down hit `CTRL+C` to free up your console, then `docker-compose down -v` to take down its containers and volumes.

-------- 

The production docker compose file is not actually used in production, but I use it to emulate the prod environment locally.

The Production Dockerfile has two different target projects:

1. `app` target builds the app completely with nginx reverse proxy and uWSGI server. This is the same configuration built in production.
`docker-compose -f docker-compose.prod.yml up app --build`

2. `test` target runs the unit tests for the django api. This returns a non-zero exit code when tests fail. So when running inside CI - failing tests will block the deployment.
`docker-compose -f docker-compose.prod.yml up test --build`

----------

## CI & CD

Github Actions is used for automated building and deployment of the app