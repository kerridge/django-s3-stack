# django-s3-stack
https://excalidraw.com/#json=5671731079413760,Vi7BYErCS7GbfuSr37uaFw

https://excalidraw.com/#json=5423642091454464,gxzMZ1UnjIQakdN9Mgim2g

## UI 
- VueJS
- Antt Design
- Bootstrap

**Deployed on:**
- Amazon S3 bucket
- Cloudfront CDN

## API
This api is made with the **Django REST framework** combined with **Wagtail CMS** on top for better models and a cleaner more powerful admin interface. The django project runs headless and the **Docker container** has an **nginx reverse proxy** to map requests to static files, api routes, and our **s3 static site**.

The application is fully Dockerized with dev and prod configurations.

## Developer setup

### You will need
- Docker
- VS Code (or any ide, but this has vscode debugging configured)

### Environment Variables
I use Github actions for deployment, so Github secrets is where you should set most of these. 

| Variable    | Description |
| ----------- | ----------- |
| DEBUG       | False  |
| DJANGO_ALLOWED_HOSTS | localhost 127.0.0.1 0.0.0.0 \[::1] |

However the container has to be publicly stored on `dockerhub.io` - so you should bake app secrets in at runtime on DigitalOcean

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

## Static & Media Files

AWS S3 bucket

------

## CI & CD

Github Actions is used for automated building and deployment of the app.

The project is structured as a monorepo and builds are only triggered when files are edited in the separate project folders.