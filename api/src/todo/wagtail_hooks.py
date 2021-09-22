from wagtail.contrib.modeladmin.options import (
    ModelAdmin, 
    ModelAdminGroup, 
    modeladmin_register 
)
from wagtail.contrib.modeladmin.views import CreateView

# from wagtail.contrib.modeladmin.mixins import ThumbnailMixin

from .models import Todo
from wagtail.contrib.modeladmin.helpers import ButtonHelper

class TodoButtonHelper(ButtonHelper):
    view_button_classnames = ['button-small', 'icon', 'icon-site'] 

    def view_button(self, obj):
        text = 'View {}'.format(obj)
        return {
            'url': '/api/v2', # TODO: decide where the button links to
            'label': text,
            'classname': self.finalise_classname(self.view_button_classnames),
            'title': text,
        }

    def get_buttons_for_obj(self, obj, exclude=None, classnames_add=None, classnames_exclude=None):
        btns = super().get_buttons_for_obj(obj, exclude, classnames_add, classnames_exclude)
        if 'view' not in (exclude or []):
            btns.append(
                self.view_button(obj)
            )
        return btns


class CreateTodoView(CreateView):
    def form_valid(self, form):
        obj = form.save()
        obj.owner = self.request.user
        return super().form_valid(form)


class TodoAdmin(ModelAdmin):
    model = Todo 
    menu_label = "Todo List"
    menu_icon = "date" 
    menu_order = 000
    add_to_settings_menu = False 
    exclude_from_explorer = False 
    list_display = ("todo_title","todo_description")
    button_helper_class = TodoButtonHelper
    list_filter = ("todo_title", "todo_description")
    search_fields = ("todo_title", "todo_description")

    list_display_add_buttons = 'todo_title'
    create_view_class = CreateTodoView


# class StoreGroup(ModelAdminGroup):
#     menu_label = "Models"
#     menu_icon = "pick"
#     menu_order = 200
#     items = (TodoAdmin)


modeladmin_register(TodoAdmin)