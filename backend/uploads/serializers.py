from dataclasses import field
from rest_framework import serializers
from .models import Upload, Result
class UploadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Upload
        fields = (
            "id",
            "detection_class"
        )


class UploadInputSerializer(serializers.ModelSerializer):
    upload = UploadSerializer(read_only=True)
    class Meta:
        model = Upload
        fields = (
            "id",
            "upload",
            "result_img",
            "time",
            "result_class",
        )