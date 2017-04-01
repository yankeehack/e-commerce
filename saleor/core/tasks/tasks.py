from __future__ import absolute_import
from time import sleep

from celery import shared_task


@shared_task
def cao(param):
    sleep(10)
    return 'The test task executed with argument "%s" ' % param
