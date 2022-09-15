from django.urls import path
from . import views

urlpatterns = [
    path("", views.child_detail_or_save_or_delete_or_update),
    path("list/", views.missing_child_list),
]