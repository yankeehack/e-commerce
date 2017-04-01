#!/bin/sh

# wait for redis server to start
sleep 10

# run Celery worker for our project myproject with Celery configuration stored in Celeryconf
su -m myuser -c "celery worker -E -l info -A saleor -Q celery -n default@%h"
