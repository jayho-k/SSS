from accounts.views import password_change
from django.urls import path
from . import views

urlpatterns = [
    path("", views.cctv_detail_or_update_or_delete),
    path("list/", views.cctv_list),
    path("create/", views.cctv_create),
    path("streaming/", views.streaming)
]
