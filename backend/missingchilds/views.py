from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from backend.common import checkuser
from .models import Child
from .serializers import (
    ChildSerializer,
    ChildListSerializer
)
# Create your views here.

# 미아 리스트
@api_view(["GET"])
def missing_child_list(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    if request.method == "GET":
        childs = user.child_set.order_by("-id")
        serializers = ChildListSerializer(childs, many=True)
        return Response(serializers.data, status=status.HTTP_200_OK)
    return Response(status=status.HTTP_403_FORBIDDEN)

# 미아정보 추가
@api_view(["POST"])
def missing_child_create(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    if request.method == "POST":
        serializer = ChildSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)
    return Response(status=status.HTTP_403_FORBIDDEN)


@api_view(["GET", "PUT", "DELETE"])
def child_detail_or_delete_or_update(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    child_id = request.data.get("id")
    child = get_object_or_404(Child,id=child_id)

    # 미아 상세정보
    if request.method == "GET":
        serializer = ChildSerializer(child)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    # 미아정보 수정
    elif request.method == "PUT":
        serializer = ChildSerializer(instance=child, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)
    
    # 미아정보 삭제
    elif request.method == "DELETE":
        child.delete()
        return Response(status=status.HTTP_200_OK)
    
    return Response(status=status.HTTP_403_FORBIDDEN)
