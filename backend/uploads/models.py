from django.db import models
from backend.common import file_upload_path
# Create your models here.
class Upload(models.Model):
    detection_class = models.CharField(max_length=5)
    activation = models.BooleanField(default=True)

class Result(models.Model):
    upload = models.ForeignKey(Upload, on_delete=models.CASCADE, related_name='results') 
    result_img = models.FileField(upload_to=file_upload_path)
    time = models.DateTimeField(auto_now_add=True)
    result_class = models.CharField(max_length=5)
    activation = models.BooleanField(default=True)