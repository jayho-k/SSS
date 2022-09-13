from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Upload, Result
from accounts.views import checkuser
from .serializers import (
    UploadSerializer,
    UploadInputSerializer
)

# Create your views here.

# 공공안전 업로드


@api_view(["POST", "DELETE"])
def upload_save_or_delete(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    get_object_or_404(get_user_model(), id=user_id)
    # 데이터 저장
    if request.method == "POST":
        serializer = UploadSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(status=status.HTTP_200_OK)
    # 데이터 삭제 
    elif request.method == "DELETE":
        upload_data = get_object_or_404(Upload, id=request.data.get("id"))
        upload_data.activation = False
        results = upload_data.results.order_by("pk")
        for result in results:
            result.activation = False
            result.save()
        upload_data.save()
        return Response(status=status.HTTP_200_OK) 


# 결과물 저장
@api_view(["POST"])
def upload_result_save(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    get_object_or_404(get_user_model(), id=user_id)
    upload_data = get_object_or_404(Upload, id=request.data.get("id"))
    if request.method == "POST":
        serializer = UploadInputSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(upload=upload_data)
            return Response(status=status.HTTP_200_OK)


