from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator


class User(AbstractUser):
    name = models.CharField(max_length=10)
    phone_number = models.CharField(max_length=13)
    department = models.CharField(max_length=20)
    is_admin = models.BooleanField(default=False)
    activation = models.IntegerField(default=0,validators=[MinValueValidator(-1), MaxValueValidator(1)])
