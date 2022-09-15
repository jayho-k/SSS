from django.db import models
from django.conf import settings
from backend.common import file_upload_path
# Create your models here.

class Child(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    child_img = models.FileField(upload_to=file_upload_path, null=True)
    missing_time = models.DateTimeField(auto_now_add=True)
    age = models.IntegerField()
    name = models.CharField(max_length=10)
    find = models.BooleanField(default=False)

