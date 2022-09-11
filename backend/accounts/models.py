from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    name = models.CharField(max_length=10)
    phone_number = models.CharField(max_length=13)
    department = models.CharField(max_length=20)
    is_admin = models.BooleanField(default=False)
    activation = models.IntegerField(default=0)