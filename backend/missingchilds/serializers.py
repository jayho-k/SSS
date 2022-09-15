from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import Child
User = get_user_model()

class ChildSerializer(serializers.ModelSerializer):
    child_img = serializers.ImageField(required=False)
    class Meta:
        model = Child
        fields = (
            "child_img",
            "missing_time",
            "age",
            "name",
            "find",
        )

class ChildListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Child
        fields = (
            "id",
            "child_img",
            "missing_time",
            "age",
            "name"
        )