#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT $POSTGRES_DB; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# python manage.py flush --no-input
python src/manage.py makemigrations
python src/manage.py migrate
python src/manage.py collectstatic --noinput

exec "$@"