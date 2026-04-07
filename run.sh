#!/bin/sh

# defaults

# ip 0.0.0.0
if [ -z "${APP_IP}" ]; then
APP_IP=0.0.0.0
fi

# port 8000
if [ -z "${APP_PORT}" ]; then
APP_PORT=8000
fi

# protocol http or uwsgi
if [ -z "${APP_PROTOCOL}" ]; then
APP_PROTOCOL=uwsgi
fi

# module name
if [ -z "${APP_MODULE}" ]; then
echo "APP_MODULE not defined !!!"
exit 1
APP_MODULE=app.wsgi
fi

# processes and threads
if [ -z "${PROCESSES}" ]; then
PROCESSES=1
fi
if [ -z "${THREADS}" ]; then
THREADS=1
fi


echo "Starting uwsgi server for ${APP_MODULE}."
echo "Listen on url: ${APP_PROTOCOL}://${APP_IP}:${APP_PORT}"
echo "       Module: ${APP_MODULE}.wsgi"
echo "    Processes: ${PROCESSES}"
echo "      Threads: ${THREADS}"
echo ""

cd /app/${APP_MODULE}

echo "Collect static files"
python3 manage.py collectstatic --noinput

uwsgi --socket "0.0.0.0:${APP_PORT}" --protocol ${APP_PROTOCOL} --module ${APP_MODULE}.wsgi --master --processes ${PROCESSES} --threads ${THREADS}
