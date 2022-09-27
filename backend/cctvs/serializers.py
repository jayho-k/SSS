from rest_framework import serializers
from .models import CCTV, Upload

class CCTVCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CCTV
        fields = (
            "user"
            "name",
            "video",
            "latitude",
            "longitude",
        )
class CCTVDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = CCTV
        fields = (
            "id",
            "name",
            "video",
            "latitude",
            "longitude",
        )
class UploadSerializer(serializers.ModelSerializer):
    video_file = serializers.FileField(required=False)
    class Meta:
        model = Upload
        fields = (
            "id",
            "video_file",
        )