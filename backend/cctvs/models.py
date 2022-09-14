from django.db import models
from django.conf import settings
# Create your models here.

class Cctv(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(max_length=20)
    video = models.CharField(max_length=20)
    latitude = models.FloatField()
    longitude = models.FloatField()