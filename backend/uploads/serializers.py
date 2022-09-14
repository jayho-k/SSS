from rest_framework import serializers
from .models import Upload, Result
from django.contrib.auth import get_user_model

User = get_user_model()
class UploadlistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Upload
        fields = (
            "id",
            "detection_class"
        )
        
class ResultDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Result
        fields = (
            "id",
            "result_img",
            "time",
            "result_class",
        )

class UploadSerializer(serializers.ModelSerializer):
    class UserSerializer(serializers.ModelSerializer):
        class Meta:
            model = User
            fields = (
            "id",
            "name"
        )
        
    user = UserSerializer(read_only=True)
    results = ResultDetailSerializer(many=True, read_only=True)
    class Meta:
        model = Upload
        fields = (
            "id",
            "user",
            "results" 
        )
            
