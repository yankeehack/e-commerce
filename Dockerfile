FROM node:boron
ADD package.json ./
ADD webpack.config.js ./
ADD ./saleor/static/ ./saleor/static/

RUN \
npm install && \
npm run build-assets

FROM python:3.5
ENV PYTHONUNBUFFERED 1

# create unprivileged user
RUN adduser --disabled-password --gecos '' myuser


ADD requirements.txt /app/
#ADD kubernetes/pycharm-debug.egg /app/pycharm-debug.egg
RUN pip install -r /app/requirements.txt
#RUN easy_install -Z /app/pycharm-debug.egg

ADD . /app
WORKDIR /app

RUN chown -R myuser:myuser /app
RUN chmod +x /app/kubernetes/run_django.sh
RUN chmod +x /app/kubernetes/run_celery.sh

EXPOSE 8000
ENV PORT 8000

CMD ["uwsgi", "/app/saleor/wsgi/uwsgi.ini"]
