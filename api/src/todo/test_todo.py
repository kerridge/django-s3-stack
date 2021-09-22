from django.test import TestCase
from .models import Todo

class TodoTestCase(TestCase):
    def setUp(self):
        Todo.objects.create(todo_title='test title', todo_description='test decription')

    def test_todo_exists(self):
        """Todos created are correctly identified"""
        todo = Todo.objects.get(todo_title='test title')
        self.assertEqual(todo.todo_description, 'test decription')