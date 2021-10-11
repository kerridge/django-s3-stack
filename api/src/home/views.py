from django.contrib.auth.models import User
from .serializers import UserSerializer
from rest_framework import viewsets


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
