# import socket # 소켓 프로그래밍에 필요한 API를 제공하는 모듈
# import struct # 바이트(bytes) 형식의 데이터 처리 모듈
# import pickle # 바이트(bytes) 형식의 데이터 변환 모듈
import sys
import os
sys.path.append(os.path.join(os.path.dirname(os.getcwd()),'mmaction2'))

from time import sleep
from tkinter import Image
from turtle import update
import cv2 # OpenCV(실시간 이미지 프로세싱) 모듈]
import threading
from django.shortcuts import get_object_or_404, render
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.response import Response
from backend.common import checkuser
from wsgiref.util import FileWrapper
from cctvs.models import CCTV, Upload
from .serializers import (
    CCTVDetailSerializer,
    UploadSerializer
)
from django.http import HttpResponse
from django.views.decorators import gzip
from yolo7deep import yolo_api
from yolo7deep import yolo_stream
from pathlib import Path
from mmaction2.demo import test_run
from django.http import StreamingHttpResponse
from PIL import Image

# mmaction2
import time
import argparse
import atexit
import copy
import logging
import queue
import mmcv
import torch
import numpy as np
from abc import ABCMeta, abstractmethod
from mmcv import Config, DictAction
from mmcv.runner import load_checkpoint
from mmaction.models import build_detector
from demo import test_run
try:
    from mmdet.apis import inference_detector, init_detector
except (ImportError, ModuleNotFoundError):
    raise ImportError('Failed to import `inference_detector` and '
                      '`init_detector` form `mmdet.apis`. These apis are '
                      'required in this demo! ')

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

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
@renderer_classes((StreamingHttpResponse))
def streaming(request,user_id,cctv_id,type):
    user = get_object_or_404(get_user_model(), id=user_id)
    cctv = get_object_or_404(CCTV, id=cctv_id)
    addr = str(cctv.video)
    # addr = 0
    if type == "fire" or type == "mia":
        cam = video_camera(addr, type, cctv_id)
        FILE = Path(__file__).resolve()
        ROOT = FILE.parents[0].parents[0] / 'yolo7deep'  # yolov5 strongsort root directory
        TRACK = ROOT.parents[0] /'media/track'
        name_exp = 'exp'
        TEMP_PIC = ROOT.parents[0] / 'Temp/pic'
        pic_id = ''.join([str(cctv_id), '.jpg'])
        if not TEMP_PIC.exists():
            TEMP_PIC.mkdir(parents=True, exist_ok=True)
        out_file = TRACK/name_exp/pic_id
        print(out_file)
        sleep(0.1)
        return StreamingHttpResponse(gen_result(out_file), content_type="multipart/x-mixed-replace;boundary=frame")
    elif type == "safety":
        video_num = str(addr)
        args = parse_api_slowfast(video_num)
        run(args)
    elif type == "normal":
        cam = normal_streaming(addr)
        return StreamingHttpResponse(gen(cam), content_type="multipart/x-mixed-replace;boundary=frame")
    return Response(request)


class normal_streaming(threading.Thread):
    def __init__(self, adrr):
        time.sleep(3)
        self._stop_event = threading.Event()
        self.video = cv2.VideoCapture(adrr) # server
        (self.grabbed, self.frame) = self.video.read()
        threading.Thread(target=self.update, args=()).start()

    def stop(self):
        self._stop_event.set()

    def stopped(self):
        return self._stop_event.is_set()

    def __del__(self):
        self.video.release()

    def get_frame(self):
        image = self.frame
        _, jpeg = cv2.imencode('.jpg', image)
        return jpeg.tobytes()

    def update(self):
        while True:
            (self.grabbed, self.frame) = self.video.read()


class video_camera(threading.Thread):
    def __init__(self, adrr, type, cctv_id):
        time.sleep(3)
        self._stop_event = threading.Event()
        self.video = cv2.VideoCapture(adrr) # server
        self.adrr = str(adrr)
        self.cctv_id = str(cctv_id)
        (self.grabbed, self.frame) = self.video.read()
        self.type = type
        FILE = Path(__file__).resolve()
        ROOT = FILE.parents[0].parents[0] / 'yolo7deep'  # yolov5 strongsort root directory
        WEIGHTS = ROOT / 'weights'
        TRACK = ROOT.parents[0] /'media/track'
        name_exp = 'exp'
        TEMP_PIC = ROOT.parents[0] / 'Temp/pic'
        pic_id = ''.join([self.cctv_id, '.jpg'])
        if not TEMP_PIC.exists():
            TEMP_PIC.mkdir(parents=True, exist_ok=True)
        temp_file = str((TEMP_PIC/pic_id))
        print(temp_file)
        cv2.imwrite(temp_file, self.frame)
        time.sleep(1)
        if self.type == 'fire':
            model = 'fire.pt'
            deepsort = False
            conf_thres = 0.4
            print(model,deepsort)
        elif self.type == 'mia':
            model = 'mia.pt'
            deepsort = True
            conf_thres = 0.5
            print(model,deepsort)
        else:
            model = 'yolov7.pt'
            deepsort = False
            conf_thres = 0.25
            print(model,deepsort)
        self.stream_yolo = yolo_stream.yolo_stream(
            source=temp_file,
            yolo_weights= WEIGHTS / model,  # model.pt path(s),
            strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
            config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
            device='cpu',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
            deepsort=deepsort, ########### MOT or not custumized variable ########################
            project=TRACK,  # save results to project/name
            name=name_exp,  # save results to project/name
            save_vid=True,  # save confidences in --save-txt labels
            classes=[0,1],  # filter by class: --class 0, or --class 0 2 3
            show_vid=False,  # show results
            conf_thres=conf_thres,  # confidence threshold
            iou_thres=0.45,  # NMS IOU threshold
        )
        self.thread = threading.Thread(target=self.update, args=())
        self.thread.start()
    def stop(self):
        self.thread.join()
        self._stop_event.set()

    def stopped(self):
        return self._stop_event.is_set()

    def __del__(self):
        self.video.release()
        self.thread.join()

    def get_frame(self):
        image = self.frame
        _, jpeg = cv2.imencode('.jpg', image)
        return jpeg.tobytes()

    def update(self):
        while True:
            (self.grabbed, self.frame) = self.video.read()
            FILE = Path(__file__).resolve()
            ROOT = FILE.parents[0].parents[0] / 'yolo7deep'  # yolov5 strongsort root directory
            TEMP_PIC = ROOT.parents[0] / 'Temp/pic'
            pic_id = ''.join([self.cctv_id, '.jpg'])
            temp_file = str((TEMP_PIC/pic_id))
            print(temp_file)
            cv2.imwrite(temp_file, self.frame)
            sleep(0.01)
            ssslog = self.stream_yolo.run()
            pred_lst.append([ssslog])
            print(ssslog, pred_lst)
            sleep(0.01)



def gen(camera):
    while True:
        frame = camera.get_frame()
        yield(b'--frame\r\n'
              b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')
    
def gen_result(pic_path):
    while True:
        pic = open(pic_path,'rb').read()
        sleep(0.2)
        yield(b'--frame\r\n'
            b'Content-Type: image/jpeg\r\n\r\n' + pic + b'\r\n\r\n')

def gen_frame(frame):
    while True:
        image = frame
        _, jpeg = cv2.imencode('.jpg', image)
        yield(b'--frame\r\n'
            b'Content-Type: image/jpeg\r\n\r\n' + jpeg + b'\r\n\r\n')
    
    
    
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
        if request.data.get("class") == "mia":
            print(WEIGHTS)
            model = 'mia.pt'
            deepsort = True
            iou_thres = 0.2
            yolo_api.yolo_detect_api(
                source=upload.video_file.path,
                yolo_weights= WEIGHTS / model,  # model.pt path(s),
                strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
                config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
                device='cpu',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
                deepsort=deepsort, ########### MOT or not custumized variable ########################
                project=TRACK,  # save results to project/name
                name=name_exp,  # save results to project/name
                save_vid=True,  # save confidences in --save-txt labels
                iou_thres=iou_thres,  # NMS IOU threshold
                classes=[0,1],  # filter by class: --class 0, or --class 0 2 3
                # line_thickness=3,  # bounding box thickness (pixels)
                # conf_thres=0.25,  # confidence threshold
                ###############################################################
                # show_vid=False,  # show results
                # imgsz=(640, 640),  # inference size (height, width)
                # max_det=1000,  # maximum detections per image
                # save_txt=False,  # save results to *.txt
                # save_conf=False,  # save confidences in --save-txt labels
                # nosave=False,  # do not save images/videos
                # exist_ok=False,  # existing project/name ok, do not increment
            )
        elif request.data.get("class") == "fire":
            # 화재 모델
            model = 'fire.pt'
            deepsort = False
            yolo_api.yolo_detect_api(
                source=upload.video_file.path,
                yolo_weights= WEIGHTS / model,  # model.pt path(s),
                strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
                config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
                device='cpu',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
                deepsort=deepsort, ########### MOT or not custumized variable ########################
                project=TRACK,  # save results to project/name
                name=name_exp,  # save results to project/name
                save_vid=True,  # save confidences in --save-txt labels
                classes=[0,1],  # filter by class: --class 0, or --class 0 2 3
                conf_thres=0.5,  # confidence threshold
                # line_thickness=3,  # bounding box thickness (pixels)
                # iou_thres=0.45,  # NMS IOU threshold
                # save_crop=False,  # save cropped prediction boxes
                ###############################################################
                # show_vid=False,  # show results
                # imgsz=(640, 640),  # inference size (height, width)
                # max_det=1000,  # maximum detections per image
                # save_txt=False,  # save results to *.txt
                # save_conf=False,  # save confidences in --save-txt labels
                # nosave=False,  # do not save images/videos
                # agnostic_nms=False,  # class-agnostic NMS
                # augment=False,  # augmented inference
                # visualize=False,  # visualize features
                # update=False,  # update all models
                # exist_ok=False,  # existing project/name ok, do not increment
                # hide_labels=False,  # hide labels
                # hide_conf=False,  # hide confidences
                # hide_class=False,  # hide IDs
                # half=False,  # use FP16 half-precision inference
                # dnn=False,  # use OpenCV DNN for ONNX inference
            )
        elif request.data.get("class") == "safety":
            # FILE_ROOT = FILE.parents[0].parents[0]
            # 공공안전
            res = upload.video_file.path.split("\\")[-1]
            input_path = upload.video_file.path
            output_path = str(TRACK / f'exp/{res}')
            test_run.run(input_path=input_path,output_path=output_path)

        videos = Upload.objects.filter(user=user_id)
        idx = videos.count()
        video = videos[idx - 1]
        video_name = str(video.video_file)
        _,_, res = video_name.split("/")
        file_name, _ = res.split(".") 
        file = FileWrapper(open(f'media/track/exp/{file_name}.mp4', mode='rb'))
        print('ddddddddddddddddddddd', file)
        # file = FileWrapper(open(f'media/video/20220930/{res}', mode='rb'))

        # response = HttpResponse(file, content_type='video/mkv')
        # response['Content-Disposition'] = 'attachment; filename=result_video.mp4'

        data = {
            "video_file": f"/media/track/exp/{file_name}.mp4"
        }
        return Response(data,status=status.HTTP_200_OK)
    return Response(status=status.HTTP_401_UNAUTHORIZED)


# slowfast
pred_lst = [] # alert
@api_view(['GET'])
def alram(request):
    rev_lsts = pred_lst[::-1]
    data = {
        'alram':rev_lsts[:20]
    }
    return Response(data, status=status.HTTP_200_OK)

class parse_api_slowfast:

    def __init__(self,input_video):
        BASE = os.path.join(os.path.dirname(os.getcwd()),'backend','mmaction2','file')
        self.config = os.path.join(BASE,'slowfast_kinetics_pretrained_r50_4x16x1_20e_ava_rgb_custom_classes.py')
        self.checkpoint = os.path.join(BASE,'latest.pth')
        self.action_score_thr = 0.4
        self.det_config = os.path.join(BASE,'yolox_s_8x8_300e_coco.py')
        self.det_checkpoint = os.path.join(BASE,'yolox_s_8x8_300e_coco_20211121_095711-4592a793.pth')
        self.det_score_thr = 0.9
        self.input_video = input_video
        self.label_map = os.path.join(BASE,'label_map.txt')
        self.device = 'cpu'
        self.output_fps = 25
        self.out_filename = None
        self.show = True
        self.display_height = 0
        self.display_width = 0
        self.predict_stepsize = 8
        self.clip_vis_length = 8
        self.cfg_options=dict()
        self.send = True

class TaskInfo:

    def __init__(self):
        self.id = -1
        self.frames = None

        # stdet params
        self.processed_frames = None
        self.frames_inds = None 
        self.img_shape = None  
        self.action_preds = None 

        self.display_bboxes = None  
        self.stdet_bboxes = None  
        self.ratio = None  

        # for each clip, draw predictions on clip_vis_length frames
        self.clip_vis_length = -1

    def add_frames(self, idx, frames, processed_frames):

        self.frames = frames
        self.processed_frames = processed_frames
        self.id = idx
        self.img_shape = processed_frames[0].shape[:2]

    def add_bboxes(self, display_bboxes):
        """Add correspondding bounding boxes."""
        self.display_bboxes = display_bboxes
        self.stdet_bboxes = display_bboxes.clone()
        self.stdet_bboxes[:, ::2] = self.stdet_bboxes[:, ::2] * self.ratio[0]
        self.stdet_bboxes[:, 1::2] = self.stdet_bboxes[:, 1::2] * self.ratio[1]

    def add_action_preds(self, preds):
        """Add the corresponding action predictions."""
        self.action_preds = preds

    def get_model_inputs(self, device):
        """Convert preprocessed images to MMAction2 STDet model inputs."""
        cur_frames = [self.processed_frames[idx] for idx in self.frames_inds]
        input_array = np.stack(cur_frames).transpose((3, 0, 1, 2))[np.newaxis]
        input_tensor = torch.from_numpy(input_array).to(device)
        return dict(
            return_loss=False,
            img=[input_tensor],
            proposals=[[self.stdet_bboxes]],
            img_metas=[[dict(img_shape=self.img_shape)]])


class BaseHumanDetector(metaclass=ABCMeta):

    def __init__(self, device):
        self.device = torch.device(device)

    @abstractmethod
    def _do_detect(self, image):
        """Get human bboxes with shape [n, 4].

        The format of bboxes is (xmin, ymin, xmax, ymax) in pixels.
        """

    def predict(self, task):

        keyframe = task.frames[len(task.frames) // 2]
        bboxes = self._do_detect(keyframe)

        if isinstance(bboxes, np.ndarray):
            bboxes = torch.from_numpy(bboxes).to(self.device)
        elif isinstance(bboxes, torch.Tensor) and bboxes.device != self.device:
            bboxes = bboxes.to(self.device)
        task.add_bboxes(bboxes)
        
        return task


class MmdetHumanDetector(BaseHumanDetector):

    def __init__(self, config, ckpt, device, score_thr, person_classid=0):
        super().__init__(device)
        self.model = init_detector(config, ckpt, device)
        self.person_classid = person_classid
        self.score_thr = score_thr

    def _do_detect(self, image):
        result = inference_detector(self.model, image)[self.person_classid]
        result = result[result[:, 4] >= self.score_thr][:, :4]
        return result


class StdetPredictor:

    def __init__(self, config, checkpoint, device, score_thr, label_map_path):
        self.score_thr = score_thr

        # load model
        config.model.backbone.pretrained = None
        model = build_detector(config.model, test_cfg=config.get('test_cfg'))
        load_checkpoint(model, checkpoint, map_location='cpu')
        model.to(device)
        model.eval()
        self.model = model
        self.device = device

        # init label map, aka class_id to class_name dict
        with open(label_map_path) as f:
            lines = f.readlines()
        lines = [x.strip().split(': ') for x in lines]
        self.label_map = {int(x[0]): x[1] for x in lines}
        try:
            if config['data']['train']['custom_classes'] is not None:
                self.label_map = {
                    id + 1: self.label_map[cls]
                    for id, cls in enumerate(config['data']['train']
                                             ['custom_classes'])
                }
        except KeyError:
            pass

    def predict(self, task):

        if len(task.stdet_bboxes) == 0:
            return task

        with torch.no_grad():
            result = self.model(**task.get_model_inputs(self.device))[0]

        preds = []
        for _ in range(task.stdet_bboxes.shape[0]):
            preds.append([])
        for class_id in range(len(result)):
            if class_id + 1 not in self.label_map:
                continue
            for bbox_id in range(task.stdet_bboxes.shape[0]):
                if result[class_id][bbox_id, 4] > self.score_thr:
                    preds[bbox_id].append((self.label_map[class_id + 1],
                                           result[class_id][bbox_id, 4]))

        task.add_action_preds(preds)

        return task

class ClipHelper:
    """Multithrading utils to manage the lifecycle of task."""

    def __init__(self,
                 config,
                 display_height=0,
                 display_width=0,
                 input_video=0,
                 predict_stepsize=40,
                 output_fps=25,
                 clip_vis_length=8,
                 out_filename=None,
                 show=True,
                 send=True,
                 stdet_input_shortside=256):
        # stdet sampling strategy
        val_pipeline = config.data.val.pipeline
        sampler = [x for x in val_pipeline
                   if x['type'] == 'SampleAVAFrames'][0]
        clip_len, frame_interval = sampler['clip_len'], sampler['frame_interval']
        self.window_size = clip_len * frame_interval

        # asserts
        assert (out_filename or show),'out_filename and show cannot both be None'
        assert clip_len % 2 == 0, 'We would like to have an even clip_len'
        assert clip_vis_length <= predict_stepsize
        assert 0 < predict_stepsize <= self.window_size

        # source params
        try:
            self.cap = cv2.VideoCapture(int(input_video))
            # self.cap = input_video
            self.webcam = True
        except ValueError:
            self.cap = cv2.VideoCapture(input_video)
            # self.cap = input_video
            self.webcam = False
        assert self.cap.isOpened()

        # stdet input preprocessing params
        h = int(self.cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
        w = int(self.cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        self.stdet_input_size = mmcv.rescale_size(
            (w, h), (stdet_input_shortside, np.Inf))
        img_norm_cfg = config['img_norm_cfg']
        if 'to_rgb' not in img_norm_cfg and 'to_bgr' in img_norm_cfg:
            to_bgr = img_norm_cfg.pop('to_bgr')
            img_norm_cfg['to_rgb'] = to_bgr
        img_norm_cfg['mean'] = np.array(img_norm_cfg['mean'])
        img_norm_cfg['std'] = np.array(img_norm_cfg['std'])
        self.img_norm_cfg = img_norm_cfg

        # task init params
        self.clip_vis_length = clip_vis_length
        self.predict_stepsize = predict_stepsize
        self.buffer_size = self.window_size - self.predict_stepsize
        frame_start = self.window_size // 2 - (clip_len // 2) * frame_interval
        self.frames_inds = [
            frame_start + frame_interval * i for i in range(clip_len)
        ]
        self.buffer = []
        self.processed_buffer = []

        # output/display params
        if display_height > 0 and display_width > 0:
            self.display_size = (display_width, display_height)
        elif display_height > 0 or display_width > 0:
            self.display_size = mmcv.rescale_size(
                (w, h), (np.Inf, max(display_height, display_width)))
        else:
            self.display_size = (w, h)
        self.ratio = tuple(
            n / o for n, o in zip(self.stdet_input_size, self.display_size))
        if output_fps <= 0:
            self.output_fps = int(self.cap.get(cv2.CAP_PROP_FPS))
        else:
            self.output_fps = output_fps
        self.show = show
        self.send = send
        self.video_writer = None
        if out_filename is not None:
            self.video_writer = self.get_output_video_writer(out_filename)
        display_start_idx = self.window_size // 2 - self.predict_stepsize // 2
        self.display_inds = [
            display_start_idx + i for i in range(self.predict_stepsize)
        ]

        # display multi-theading params
        self.display_id = -1  # task.id for display queue
        self.display_queue = {}
        self.display_lock = threading.Lock()
        self.output_lock = threading.Lock()

        # read multi-theading params
        self.read_id = -1  # task.id for read queue
        self.read_id_lock = threading.Lock()
        self.read_queue = queue.Queue()
        self.read_lock = threading.Lock()
        self.not_end = True  # cap.read() flag

        # program state
        self.stopped = False

        atexit.register(self.clean)

    def read_fn(self):

        was_read = True
        start_time = time.time()
        while was_read and not self.stopped:
            # init task
            task = TaskInfo()
            task.clip_vis_length = self.clip_vis_length
            task.frames_inds = self.frames_inds
            task.ratio = self.ratio

            # read buffer
            frames = []
            processed_frames = []
            if len(self.buffer) != 0:
                frames = self.buffer
            if len(self.processed_buffer) != 0:
                processed_frames = self.processed_buffer

            # read and preprocess frames from source and update task
            with self.read_lock:
                before_read = time.time()
                read_frame_cnt = self.window_size - len(frames)
                while was_read and len(frames) < self.window_size:
                    was_read, frame = self.cap.read()
                    if not self.webcam:
                        time.sleep(1 / self.output_fps)
                    if was_read:
                        frames.append(mmcv.imresize(frame, self.display_size))
                        processed_frame = mmcv.imresize(
                            frame, self.stdet_input_size).astype(np.float32)
                        _ = mmcv.imnormalize_(processed_frame,
                                              **self.img_norm_cfg)
                        processed_frames.append(processed_frame)
            task.add_frames(self.read_id + 1, frames, processed_frames)

            # update buffer
            if was_read:
                self.buffer = frames[-self.buffer_size:]
                self.processed_buffer = processed_frames[-self.buffer_size:]

            # update read state
            with self.read_id_lock:
                self.read_id += 1
                self.not_end = was_read

            self.read_queue.put((was_read, copy.deepcopy(task)))
            cur_time = time.time()
            logger.debug(
                f'Read thread: {1000*(cur_time - start_time):.0f} ms, '
                f'{read_frame_cnt / (cur_time - before_read):.0f} fps')
            start_time = cur_time

    def display_fn(self):

        start_time = time.time()
        while not self.stopped:
            # get the state of the read thread
            with self.read_id_lock:
                read_id = self.read_id
                not_end = self.not_end

            with self.display_lock:
                # If video ended and we have display all frames.
                if not not_end and self.display_id == read_id:
                    break

                # If the next task are not available, wait.
                if (len(self.display_queue) == 0 or
                        self.display_queue.get(self.display_id + 1) is None):
                    time.sleep(0.02)
                    continue

                # get display data and update state
                self.display_id += 1
                was_read, task = self.display_queue[self.display_id]
                del self.display_queue[self.display_id]
                display_id = self.display_id

            # do display predictions
            with self.output_lock:
                if was_read and task.id == 0:
                    # the first task
                    cur_display_inds = range(self.display_inds[-1] + 1)
                elif not was_read:
                    # the last task
                    cur_display_inds = range(self.display_inds[0],
                                             len(task.frames))
                else:
                    cur_display_inds = self.display_inds

                for frame_id in cur_display_inds:
                    frame,image = self.get_frame(frame_id,task)
                    if self.send:
                        pass
                    
                    if self.show:
                        pass
                        # cv2.imshow('Demo', frame)
                        # cv2.waitKey(int(1000 / self.output_fps))

                    if self.video_writer:
                        self.video_writer.write(frame)

            cur_time = time.time()
            logger.debug(
                f'Display thread: {1000*(cur_time - start_time):.0f} ms, '
                f'read id {read_id}, display id {display_id}')
            start_time = cur_time

    def get_frame(self,frame_id,task):
        frame = task.frames[frame_id]
        _, jpeg = cv2.imencode('.jpg', frame)
        image = jpeg.tobytes()
        return frame, image
 
    def __iter__(self):
        return self

    def __next__(self):
        """Get data from read queue.

        This function is part of the main thread.
        """
        if self.read_queue.qsize() == 0:
            time.sleep(0.02)
            return not self.stopped, None

        was_read, task = self.read_queue.get()
        if not was_read:
            # If we reach the end of the video, there aren't enough frames
            # in the task.processed_frames, so no need to model inference
            # and draw predictions. Put task into display queue.
            with self.read_id_lock:
                read_id = self.read_id
            with self.display_lock:
                self.display_queue[read_id] = was_read, copy.deepcopy(task)

            # main thread doesn't need to handle this task again
            task = None
        return was_read, task

    def start(self):
        """Start read thread and display thread."""
        self.read_thread = threading.Thread(
        target=self.read_fn, args=(), name='VidRead-Thread', daemon=True)
        self.read_thread.start()
        
        self.display_thread = threading.Thread(
            target=self.display_fn,
            args=(),
            name='VidDisplay-Thread',
            daemon=True)
        self.display_thread.start()
        return self

    def clean(self):
        """Close all threads and release all resources."""
        self.stopped = True
        self.read_lock.acquire()
        self.cap.release()
        self.read_lock.release()
        self.output_lock.acquire()
        cv2.destroyAllWindows()
        if self.video_writer:
            self.video_writer.release()
        self.output_lock.release()

    def join(self):
        
        self.read_thread.join()
        self.display_thread.join()

    def display(self, task):

        with self.display_lock:
            self.display_queue[task.id] = (True, task)

    def get_output_video_writer(self, path):

        return cv2.VideoWriter(
            filename=path,
            fourcc=cv2.VideoWriter_fourcc(*'x264'),
            fps=float(self.output_fps),
            frameSize=self.display_size,
            isColor=True)

class BaseVisualizer(metaclass=ABCMeta):
    """Base class for visualization tools."""

    def __init__(self, max_labels_per_bbox):
        self.max_labels_per_bbox = max_labels_per_bbox

    def draw_predictions(self, task):
        """Visualize stdet predictions on raw frames."""
        # read bboxes from task
        bboxes = task.display_bboxes.cpu().numpy()

        # draw predictions and update task
        keyframe_idx = len(task.frames) // 2
        draw_range = [
            keyframe_idx - task.clip_vis_length // 2,
            keyframe_idx + (task.clip_vis_length - 1) // 2
        ]
        assert draw_range[0] >= 0 and draw_range[1] < len(task.frames)
        task.frames = self.draw_clip_range(task.frames, task.action_preds,bboxes, draw_range)

        return task

    def draw_clip_range(self, frames, preds, bboxes, draw_range):
        """Draw a range of frames with the same bboxes and predictions."""
        # no predictions to be draw
        if bboxes is None or len(bboxes) == 0:
            return frames

        # draw frames in `draw_range`
        left_frames = frames[:draw_range[0]]
        right_frames = frames[draw_range[1] + 1:]
        draw_frames = frames[draw_range[0]:draw_range[1] + 1]

        # get labels(texts) and draw predictions
        draw_frames = [self.draw_one_image(frame, bboxes, preds) for frame in draw_frames]

        return list(left_frames) + draw_frames + list(right_frames)

    @abstractmethod
    def draw_one_image(self, frame, bboxes, preds):
        """Draw bboxes and corresponding texts on one frame."""

    @staticmethod
    def abbrev(name):
        """Get the abbreviation of label name:

        'take (an object) from (a person)' -> 'take ... from ...'
        """
        while name.find('(') != -1:
            st, ed = name.find('('), name.find(')')
            name = name[:st] + '...' + name[ed + 1:]
        return name


class DefaultVisualizer(BaseVisualizer):

    def __init__(
            self,
            max_labels_per_bbox=5,
            plate='03045e-023e8a-0077b6-0096c7-00b4d8-48cae4',
            text_fontface=cv2.FONT_HERSHEY_DUPLEX,
            text_fontscale=0.5,
            text_fontcolor=(255, 255, 255),  # white
            text_thickness=1,
            text_linetype=1):
        super().__init__(max_labels_per_bbox=max_labels_per_bbox)
        self.text_fontface = text_fontface
        self.text_fontscale = text_fontscale
        self.text_fontcolor = text_fontcolor
        self.text_thickness = text_thickness
        self.text_linetype = text_linetype

        def hex2color(h):
            """Convert the 6-digit hex string to tuple of 3 int value (RGB)"""
            return (int(h[:2], 16), int(h[2:4], 16), int(h[4:], 16))

        plate = plate.split('-')
        self.plate = [hex2color(h) for h in plate]

    def draw_one_image(self, frame, bboxes, preds):
        """Draw predictions on one image."""
        for bbox, pred in zip(bboxes, preds):
            # draw bbox
            box = bbox.astype(np.int64)
            st, ed = tuple(box[:2]), tuple(box[2:])
            cv2.rectangle(frame, st, ed, (0, 0, 255), 2)

            # draw texts
            for k, (label, score) in enumerate(pred):
                if k >= self.max_labels_per_bbox:
                    break
                text = f'{self.abbrev(label)}: {score:.4f}'
                location = (0 + st[0], 18 + k * 18 + st[1])
                textsize = cv2.getTextSize(text, self.text_fontface, self.text_fontscale, self.text_thickness)[0]
                textwidth = textsize[0]
                diag0 = (location[0] + textwidth, location[1] - 14)
                diag1 = (location[0], location[1] + 2)
                cv2.rectangle(frame, diag0, diag1, self.plate[k + 1], -1)
                cv2.putText(frame, text, location, self.text_fontface,
                            self.text_fontscale, self.text_fontcolor,
                            self.text_thickness, self.text_linetype)
        return frame

def run(args):
    # init human detector
    human_detector = MmdetHumanDetector(args.det_config, args.det_checkpoint,
                                        args.device, args.det_score_thr)
    # init action detector
    config = Config.fromfile(args.config)
    config.merge_from_dict(args.cfg_options)

    try:
        # In our spatiotemporal detection demo, different actions should have
        # the same number of bboxes.
        config['model']['test_cfg']['rcnn']['action_thr'] = .0
    except KeyError:
        pass
    stdet_predictor = StdetPredictor(
        config=config,
        checkpoint=args.checkpoint,
        device=args.device,
        score_thr=args.action_score_thr,
        label_map_path=args.label_map)

    # init clip helper
    clip_helper = ClipHelper(
        config=config,
        display_height=args.display_height,
        display_width=args.display_width,
        input_video=args.input_video,
        predict_stepsize=args.predict_stepsize,
        output_fps=args.output_fps,
        clip_vis_length=args.clip_vis_length,
        out_filename=args.out_filename,
        show=args.show)

    # init visualizer
    vis = DefaultVisualizer()
    
    
    # start read and display thread
    clip_helper.start()
        
    try:

        st = threading.Thread(target=main_thread, args=(clip_helper,human_detector,stdet_predictor,vis))
        st.start()
        # streaming_test(clip_helper.display_fn())
        clip_helper.join()

    except KeyboardInterrupt:
        pass
    finally:
        # close read & display thread, release all resources
        clip_helper.clean()


def main_thread(clip_helper,human_detector,stdet_predictor,vis):
    for able_to_read, task in clip_helper:

            if not able_to_read:
                break

            if task is None:
                time.sleep(0.01)
                continue

            inference_start = time.time()
            human_detector.predict(task)
            stdet_predictor.predict(task)

            vis.draw_predictions(task)
            logger.info(f'Stdet Results: {task.action_preds}')
            if task.action_preds != None:
                something_lock = threading.Lock()
                with something_lock:

                    class_name = task.action_preds[0][0][0]
                    prediction = task.action_preds[0][0][1]
                    if prediction >= 0.7:
                        pred_lst.append([class_name])
                    # time.sleep(0)

            clip_helper.display(task)

            logger.debug('Main thread inference time '
                        f'{1000*(time.time() - inference_start):.0f} ms')
