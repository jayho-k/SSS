from django.db import models

# Create your models here.
class Upload(models.Model):
    detection_class = models.CharField(max_length=5)
    activation = models.BooleanField(default=True)

class Result(models.Model):
    upload = models.ForeignKey(Upload, on_delete=models.CASCADE, related_name='results') 
    result_img = models.CharField(max_length=100)
    time = models.DateTimeField(auto_now_add=True)
    result_class = models.CharField(max_length=5)
    activation = models.BooleanField(default=True)