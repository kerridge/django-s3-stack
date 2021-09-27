from rest_framework import serializers
from .models import Todo

class TodoSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Todo
        fields = ['url', 'id', 'todo_title', 'todo_description', 'created', 'owner']

    def get_api_spec(todo: Todo, fields: list):
        return {k: v for k, v in todo.__dict__.items() if k in fields}