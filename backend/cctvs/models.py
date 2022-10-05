from django.db import models
from django.conf import settings
from backend.common import file_upload_path
# Create your models here.

class CCTV(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=20)
    video = models.CharField(max_length=100)
    latitude = models.FloatField()
    longitude = models.FloatField()
    
    
class Upload(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    video_file = models.FileField(upload_to=file_upload_path)