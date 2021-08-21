# pull official base image
FROM python:3.8.3-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
    # install psycopg2 dependencies
    && apk add postgresql-dev gcc python3-dev musl-dev \
    # install missing libraries for python package `Pillow` to use
    && apk add build-base py-pip jpeg-dev zlib-dev

ENV LIBRARY_PATH=/lib:/usr/lib

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]