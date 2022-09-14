from django.db import models
from cctvs.models import CCTV
from uploads.models import Upload
from backend.common import file_upload_path
# Create your models here.

class Child(models.Model):
    cctv = models.ManyToManyField(CCTV, related_name="child_cctv", null=True)
    chlid_class = models.TextField()
    

class Result(models.Model):
    child = models.ForeignKey(Child, on_delete=models.CASCADE)
    result_img = models.FileField(upload_to=file_upload_path)
    time = models.DateTimeField()

