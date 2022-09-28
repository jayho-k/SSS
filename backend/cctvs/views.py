# import socket # 소켓 프로그래밍에 필요한 API를 제공하는 모듈
# import struct # 바이트(bytes) 형식의 데이터 처리 모듈
# import pickle # 바이트(bytes) 형식의 데이터 변환 모듈
import cv2 # OpenCV(실시간 이미지 프로세싱) 모듈]
import threading
from django.shortcuts import get_object_or_404, render
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from backend.common import checkuser

from cctvs.models import CCTV, Upload
from .serializers import (
    CCTVDetailSerializer,
    UploadSerializer
)
from django.http import StreamingHttpResponse
from django.views.decorators import gzip
from Yolov7_StrongSORT_OSNet import yolo_api
from pathlib import Path



@api_view(["GET"])
def cctv_list(request):
    if request.method == "GET":
        token = request.META.get("HTTP_AUTHORIZATION")
        user_id = checkuser(token)
        user = get_object_or_404(get_user_model(), id=user_id)

        cctvs = CCTV.objects.order_by("id").filter(user=user_id)
        serializer = CCTVDetailSerializer(cctvs, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response(status=status.HTTP_403_FORBIDDEN)

@api_view(["POST"])
def cctv_create(request):
    if request.method == "POST":
        token = request.META.get("HTTP_AUTHORIZATION")
        user_id = checkuser(token)
        user = get_object_or_404(get_user_model(), id=user_id)

        serializer = CCTVDetailSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_403_FORBIDDEN)

# cctv crud api
@api_view(["GET", "PUT", "DELETE"])
def cctv_detail_or_update_or_delete(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    cctv_id = request.data.get("id")
    cctv = get_object_or_404(CCTV, id=cctv_id)
    
    if request.method == "GET":
        serializer = CCTVDetailSerializer(cctv)
        return Response(serializer.data, status=status.HTTP_200_OK)

    elif request.method == "PUT":
        serializer = CCTVDetailSerializer(instance=cctv, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
        return Response(status=status.HTTP_200_OK)

    elif request.method == "DELETE":
        cctv.delete()
        return Response(status=status.HTTP_200_OK)

    return Response(status=status.HTTP_403_FORBIDDEN)



@gzip.gzip_page
def streaming(request):
    try:
        cam = video_camera()
        return StreamingHttpResponse(gen(cam), content_type="multipart/x-mixed-replace;boundary=frame")
    except:
        pass
    return Response(request)

class video_camera(object):
    def __init__(self):
        # self.video = cv2.VideoCapture('http://qwerasdf1234:1q2w3e4r@192.168.0.26:8080/video') # local
        self.video = cv2.VideoCapture('rtsp://192.0.0.2:8554/live') # server
        (self.grabbed, self.frame) = self.video.read()
        threading.Thread(target=self.update, args=()).start()
    
    def __del__(self):
        self.video.release()

    def get_frame(self):
        image = self.frame
        _, jpeg = cv2.imencode('.jpg', image)
        return jpeg.tobytes()

    def update(self):
        while True:
            (self.grabbed, self.frame) = self.video.read()
    
def gen(camera):
    while True:
        frame = camera.get_frame()
        yield(b'--frame\r\n'
              b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')
    
    
    
@api_view(["POST"])
def upload(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    if request.method == "POST":
        upload = Upload.objects.create(video_file=request.FILES["video"],user=user)
        file=request.FILES["video"]
        print(type(request.FILES["video"]))
        print(upload.video_file.path.split("\\")[-1])
        upload.save()

        FILE = Path(__file__).resolve() 
        ROOT = FILE.parents[0].parents[0] / 'yolo7deep'  # yolov5 strongsort root directory
        WEIGHTS = ROOT / 'weights'
        TRACK = ROOT.parents[0] /'media/track'
        name_exp = 'exp'
        print(WEIGHTS)
        yolo_api.yolo_detect_api(
        source=upload.video_file.path,
        yolo_weights= WEIGHTS / 'yolov7.pt',  # model.pt path(s),
        strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
        config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
        device='cpu',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
        deepsort=True, ########### MOT or not custumized variable ########################
        project=TRACK,  # save results to project/name
        name=name_exp,  # save results to project/name
        save_vid=True,  # save confidences in --save-txt labels
        classes=[0],  # filter by class: --class 0, or --class 0 2 3
        # show_vid=False,  # show results
        # yolo_weights=WEIGHTS / 'yolov5m.pt',  # model.pt path(s),
        # strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
        # config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
        # imgsz=(640, 640),  # inference size (height, width)
        # conf_thres=0.25,  # confidence threshold
        # iou_thres=0.45,  # NMS IOU threshold
        # max_det=1000,  # maximum detections per image
        # device='',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
        # save_txt=False,  # save results to *.txt
        # save_conf=False,  # save confidences in --save-txt labels
        # save_crop=False,  # save cropped prediction boxes
        # nosave=False,  # do not save images/videos
        # agnostic_nms=False,  # class-agnostic NMS
        # augment=False,  # augmented inference
        # visualize=False,  # visualize features
        # update=False,  # update all models
        # exist_ok=False,  # existing project/name ok, do not increment
        # line_thickness=3,  # bounding box thickness (pixels)
        # hide_labels=False,  # hide labels
        # hide_conf=False,  # hide confidences
        # hide_class=False,  # hide IDs
        # half=False,  # use FP16 half-precision inference
        # dnn=False,  # use OpenCV DNN for ONNX inference
        )


            
        videos = Upload.objects.filter(user=user_id)
        idx = videos.count()
        video = videos[idx - 1]
        video_name = str(video.video_file)
        _,_, res = video_name.split("/")
        data = {
            "video_file": f"/media/track/exp/{res}"
        }
        return Response(data,status=status.HTTP_200_OK)
    return Response(status=status.HTTP_401_UNAUTHORIZED)
