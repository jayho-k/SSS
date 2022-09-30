from django.urls import path
from . import views

urlpatterns = [
    path("", views.child_detail_or_delete_or_update),
    path("create/",views.missing_child_create),
    path("list/", views.missing_child_list),
]