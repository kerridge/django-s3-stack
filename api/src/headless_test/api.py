from wagtail.api.v2.views import PagesAPIViewSet
from wagtail.api.v2.router import WagtailAPIRouter
from wagtail.images.api.v2.views import ImagesAPIViewSet
from wagtail.documents.api.v2.views import DocumentsAPIViewSet
from rest_framework.routers import DefaultRouter

from home import views as home
from todo import views as todo


# Wagtail routing
api_router = WagtailAPIRouter('wagtailapi')

api_router.register_endpoint('pages', PagesAPIViewSet)
api_router.register_endpoint('images', ImagesAPIViewSet)

# Django routing
router = DefaultRouter()

router.register(r'todos', todo.TodoViewSet)
router.register(r'users', home.UserViewSet)

# from wagtail.api.v2.views import PagesAPIViewSet, PageSerializer


# class MyCustomPagesAPIViewSet(PagesAPIViewSet):
#     base_serializer_class = PageSerializer

#     body_fields = [
#         'title',
#     ]

#     meta_fields = [
#         'parent',
#     ]


# api_router.register_endpoint('pages', MyCustomPagesAPIViewSet)