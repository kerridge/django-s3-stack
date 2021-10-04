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

# Must be secret
AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')

# Can be public 
AWS_STORAGE_BUCKET_NAME = os.getenv('AWS_STORAGE_BUCKET_NAME')
AWS_S3_REGION_NAME = os.getenv('AWS_S3_REGION_NAME')

AWS_S3_CUSTOM_DOMAIN = '%s.s3.amazonaws.com' % AWS_STORAGE_BUCKET_NAME

AWS_S3_OBJECT_PARAMETERS = {
    'CacheControl': 'max-age=86400',
}
AWS_LOCATION = 'static'
AWS_DEFAULT_ACL = 'public-read'

STATICFILES_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'

STATIC_URL = '{}/{}/'.format(AWS_S3_CUSTOM_DOMAIN, AWS_LOCATION)
STATIC_ROOT = 'static/'


try:
    from .local import *
except ImportError:
    pass
