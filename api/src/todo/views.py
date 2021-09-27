from .models import Todo
from .serializers import TodoSerializer
from .permissions import IsOwnerOrReadOnly
from rest_framework import fields, permissions, response, serializers, viewsets
from drf_spectacular.utils import extend_schema, OpenApiParameter, OpenApiExample
from drf_spectacular.types import OpenApiTypes


@extend_schema(tags=["todo"])
class TodoViewSet(viewsets.ModelViewSet):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

    @extend_schema(
        description='Create a new `todo` object',
        parameters=[
            OpenApiParameter(name='todo_title', description='The name of the todo', required=True, type=str),
            OpenApiParameter(name='todo_description', description='A description of the todo to be done', required=False, type=str),
        ],
        examples=[
            OpenApiExample(
                'With description',
                description='',
                value=TodoSerializer.get_api_spec(
                    Todo(todo_title='Clean room', todo_description='Pick up all the clothes on ya floor'),
                    ['todo_title', 'todo_description']
                ),
                request_only=True
            )
        ],
    )
    def create(self, request):
        pass