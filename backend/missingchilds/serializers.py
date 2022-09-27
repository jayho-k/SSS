from rest_framework import serializers
from .models import Child


class ChildSerializer(serializers.ModelSerializer):
    child_img = serializers.ImageField(required=False)
    class Meta:
        model = Child
        fields = (
            "id",
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
        
