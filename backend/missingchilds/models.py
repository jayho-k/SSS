from django.db import models
# Create your models here.

class Child(models.Model):
    gender = models.CharField(max_length=50)
    age = models.IntegerField()
    top_category = models.CharField(max_length=50)
    top_color = models.CharField(max_length=50)
    bottom_category = models.CharField(max_length=50)
    bottom_color = models.CharField(max_length=50)
    belonging = models.CharField(max_length=50)
    pet = models.CharField(max_length=50)
    video_url = models.CharField(max_length=50)
    activation = models.BooleanField(default=True)


class Result(models.Model):
    result_img = models.CharField(max_length=50)
    time = models.DateTimeField()
    place = models.CharField(max_length=50)
    activation = models.BooleanField(default=True)