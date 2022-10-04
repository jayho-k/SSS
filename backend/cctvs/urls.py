from accounts.views import password_change
from django.urls import path
from . import views

urlpatterns = [
    path("", views.cctv_detail_or_update_or_delete),
    path("list/", views.cctv_list),
    path("create/", views.cctv_create),
    path("<int:user_id>/<int:cctv_id>/streaming/<type>", views.streaming),
    path("upload/", views.upload),
]