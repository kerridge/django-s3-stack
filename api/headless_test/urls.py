from django.conf import settings
from django.urls import include, path, re_path
from django.contrib import admin

from wagtail.admin import urls as wagtailadmin_urls
from wagtail.core import urls as wagtail_urls
from wagtail.documents import urls as wagtaildocs_urls

from search import views as search_views

from .api import api_router, router

from django.conf.urls import include, url
from django.contrib.staticfiles.views import serve
from django.views.generic import RedirectView



urlpatterns = [
    path('django-admin/', admin.site.urls),
    path('admin/', include(wagtailadmin_urls)),

    path('search/', search_views.search, name='search'),

    # static files (*.css, *.js, *.jpg etc.) served on /
    # (assuming Django uses /static/ and /media/ for static/media urls)
    # url(r'^bitch/', serve, kwargs={'path': 'dist/index.html'}),
    # url(r'^(?!/?static/)(?!/?media/)(?P<path>.*\..*)$',
    #     RedirectView.as_view(url='/static/%(path)s', permanent=False)),

    path('api/', api_router.urls),
    path('api/v2/', include(router.urls)),

    re_path(r'^', include(wagtail_urls)),
]


if settings.DEBUG:
    from django.conf.urls.static import static
    from django.contrib.staticfiles.urls import staticfiles_urlpatterns

    # Serve static and media files from development server
    urlpatterns += staticfiles_urlpatterns()
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

