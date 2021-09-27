from .base import *

SECRET_KEY = os.environ.get("SECRET_KEY", 'shh')
DEBUG = int(os.environ.get("DEBUG", default=0))
ALLOWED_HOSTS = os.environ.get("DJANGO_ALLOWED_HOSTS", '127.0.0.1').split(" ")

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

INSTALLED_APPS += ['drf_spectacular']

REST_FRAMEWORK = {
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

SPECTACULAR_SETTINGS = {
    'TITLE': 'Django Vue Template',
    'DESCRIPTION': 'Your project description',
    'VERSION': '1.0.0',
    'COMPONENT_SPLIT_REQUEST': True
}

try:
    from .local import *
except ImportError:
    pass
