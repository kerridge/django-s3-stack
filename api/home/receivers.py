from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Todo

import logging
logger = logging.getLogger("mylogger")


@receiver(post_save, sender=Todo)
def my_handler(sender, **kwargs):
    logger.info("SUP BITCH")