from accounts.views import password_change
from django.urls import path
from . import views

urlpatterns = [
    path("/cctvs", views.cctv_detail_or_create_or_update_or_delete),
]
