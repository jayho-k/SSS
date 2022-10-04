from http.client import HTTPResponse
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from backend.common import checkuser
from django.http import StreamingHttpResponse
from django.views.decorators import gzip
import cv2
import threading


@api_view(["GET"])
def upload(request):
    # if request.data.get("fire"):
    #     pass
    # else if request.data.get("fire"):
    #     pass
    # data = {
    #     "result": "good"
    # }
    cam = request.FILES
    print(type(cam))
    # if cam.isOpened():
    #     print("good")
    # else:
    #     print("bad")
    # while True:
    #     cam.read()
    #     print(res)
    #     cv2.imshow('image', img)
    #     if cv2.waitKey(1) & 0xFF == 27:
    #         break
    # else:
    #     return Response(status=status.HTTP_200_OK)
    cam.read()
    return Response(status=status.HTTP_400_BAD_REQUEST)
    

