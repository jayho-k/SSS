from rest_framework import serializers
from .models import CCTV

class CCTVCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CCTV
        fields = (
            "user"
            "name",
            "video",
            "latitude",
            "longtitude",
        )
class CCTVDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = CCTV
        fields = (
            "name",
            "video",
            "latitude",
            "longtitude",
        )
