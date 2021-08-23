#!/bin/sh
pwd
docker run -p 5010:80 -d \
  --name django_s3_stack \
  --env-file .env.prod \
django_s3_stack