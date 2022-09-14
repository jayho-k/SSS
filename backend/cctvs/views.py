from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from backend.common import checkuser

from cctvs.models import CCTV
from .serializers import CCTVDetailSerializer

# cctv crud api
@api_view(["GET", "POST", "PUT", "DELETE"])
def cctv_detail_or_create_or_update_or_delete(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    cctv_id = request.data.get("id")
    cctv = get_object_or_404(CCTV, id=cctv_id)

    if request.method == "GET":
        cctvs = CCTV.objects.order_by("id").filter(user=user_id)
        serializer = CCTVDetailSerializer(cctvs, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    elif request.method == "POST":
        serializer = CCTVDetailSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)

    elif request.method == "PUT":
        serializer = CCTVDetailSerializer(cctv)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)

    elif request.method == "DELETE":
        cctv.delete()
        return Response(status=status.HTTP_200_OK)

    return Response(status=status.HTTP_403_FORBIDDEN)