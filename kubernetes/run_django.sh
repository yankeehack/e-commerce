#!/bin/sh


su -m myuser -c "python manage.py collectstatic --noinput"
su -m myuser -c "python manage.py flush --noinput"
su -m myuser -c "python manage.py migrate"
su -m myuser -c "python manage.py populatedb --createsuperuser"
su -m myuser -c "python manage.py runserver 0.0.0.0:8000"
