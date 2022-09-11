from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    Name = models.CharField(max_length=10)
    phonenumber = models.CharField(max_length=13)
    department = models.CharField(max_length=20)
    is_admin = models.BooleanField(default=False)
    activation = models.BooleanField(default=False)