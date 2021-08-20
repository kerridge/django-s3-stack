from django.db import models

from wagtail.core.models import Page
from wagtail.core.fields import RichTextField
from django.contrib.auth import get_user_model

from wagtail.admin.edit_handlers import (
    FieldPanel,
    ObjectList,
    TabbedInterface,
)


class BaseMetatdataModel(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    owner = models.ForeignKey(
        get_user_model(),
        related_name='todos',
        null=True,
        blank=True,
        on_delete=models.SET_NULL)

    class Meta:
        abstract = True
        ordering = ['created']

class HomePage(Page):
    body = RichTextField(blank=True)

    content_panels = Page.content_panels + [
        FieldPanel('body', classname="full"),
    ]


class Todo(BaseMetatdataModel):
    todo_title = models.CharField(max_length=100, blank=True, default='')
    todo_description = models.CharField(max_length=200, blank=True, default='')

    def __str__(self) -> str:
        return self.todo_title        

    todo_panels = [
        FieldPanel('todo_title'),
        FieldPanel('todo_description'),
    ]

    edit_handler = TabbedInterface(
        [
            ObjectList(todo_panels, heading='Details'),
        ]
    )
