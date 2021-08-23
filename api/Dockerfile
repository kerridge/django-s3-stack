FROM python:3.8.3-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    # gcc python3-dev musl-dev \
    # build-base py-pip jpeg-dev zlib-dev \
    netcat 

# install dependencies
RUN pip install --upgrade pip
COPY ./src/requirements.txt .
RUN pip install -r requirements.txt

COPY ./entrypoint.sh .

# copy project
COPY src src/

# run entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]