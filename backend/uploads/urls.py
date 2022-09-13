from django.urls import path
from . import views

urlpatterns = [
    path("", views.upload_save_or_delete),
    path("result/", views.upload_result_save)
]