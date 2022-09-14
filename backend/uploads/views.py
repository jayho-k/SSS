from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Upload, Result
from backend.common import checkuser
from .serializers import (
    UploadSerializer,
    UploadlistSerializer,
    ResultDetailSerializer
)

# Create your views here.

# 공공안전 업로드
@api_view(["GET"])
def upload_list(requset):
    token = requset.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    uploads = user.upload_set.order_by("pk")
    serializers = UploadlistSerializer(uploads, many=True)
    return Response(serializers.data)
    


@api_view(["GET", "POST", "DELETE"])
def upload_detail_or_save_or_delete(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    # 결과 상세정보 전송
    if request.method == "GET":
        upload_data = get_object_or_404(Upload, id=request.data.get("id"))
        serializer = UploadSerializer(upload_data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    # 데이터 저장
    if request.method == "POST":
        serializer = UploadlistSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
            return Response(status=status.HTTP_200_OK)
        
    # 데이터 삭제 
    elif request.method == "DELETE":
        upload_data = get_object_or_404(Upload, id=request.data.get("id"))
        upload_data.delete()
        return Response(status=status.HTTP_200_OK) 


# 결과물 저장
@api_view(["POST"])
def upload_result_save(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    upload_data = get_object_or_404(Upload, id=request.data.get("id"))
    if request.method == "POST":
        serializer = ResultDetailSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user,upload=upload_data)
            return Response(status=status.HTTP_200_OK)


