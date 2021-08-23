from .base import *

SECRET_KEY = os.environ.get("SECRET_KEY", 'shh')
DEBUG = int(os.environ.get("DEBUG", default=0))
ALLOWED_HOSTS = os.environ.get("DJANGO_ALLOWED_HOSTS", '127.0.0.1').split(" ")

try:
    from .local import *
except ImportError:
    pass
