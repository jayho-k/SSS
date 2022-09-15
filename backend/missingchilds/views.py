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
@api_view(["GET", "POST", "PUT", "DELETE"])
def child_detail_or_save_or_delete_or_update(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    if request.method == "GET":
        child_id = request.data.get("id")
        child = get_object_or_404(Child,id=child_id)
        serializer = ChildSerializer(child)
        return Response(serializer.data, status=status.HTTP_200_OK)
    elif request.method == "POST":
        serializer = ChildSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)
    elif request.method == "PUT":
        child_id = request.data.get("id")
        child = get_object_or_404(Child,id=child_id)
        serializer = ChildSerializer(instance=child, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)
    elif request.method == "DELETE":
        child_id = request.data.get("id")
        child = get_object_or_404(Child,id=child_id)
        child.delete()
        return Response(status=status.HTTP_200_OK)



@api_view(["GET"])
def missing_child_list(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    if request.method == "GET":
        childs = user.child_set.order_by("-id")
        serializers = ChildListSerializer(childs, many=True)
        return Response(serializers.data, status=status.HTTP_200_OK)