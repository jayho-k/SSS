from django.db import models

# Create your models here.
class Upload(models.Model):
    detection_class = models.CharField(max_length=5)
    video_url = models.URLField()
    activation = models.BooleanField()

class Result(models.Model):
    upload = models.ForeignKey(Upload, on_delete=models.CASCADE)
    result_img = models.CharField(max_length=100)
    time = models.DateTimeField()
    place = models.CharField(max_length=30)
    result_class = models.CharField(max_length=5)
    activation = models.BooleanField()