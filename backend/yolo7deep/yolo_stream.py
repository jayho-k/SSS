import argparse
from doctest import FAIL_FAST

import os
from tkinter import Variable



# limit the number of cpus used by high performance libraries
os.environ["OMP_NUM_THREADS"] = "1"
os.environ["OPENBLAS_NUM_THREADS"] = "1"
os.environ["MKL_NUM_THREADS"] = "1"
os.environ["VECLIB_MAXIMUM_THREADS"] = "1"
os.environ["NUMEXPR_NUM_THREADS"] = "1"

os.environ.setdefault("DJANGO_SETTINGS_MODULE","backend.settings")

import sys
import numpy as np
from pathlib import Path
import torch
import torch.backends.cudnn as cudnn
from numpy import random


FILE = Path(__file__).resolve()
ROOT = FILE.parents[0]  # yolov5 strongsort root directory
WEIGHTS = ROOT / 'weights'

if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))  # add ROOT to PATH
if str(ROOT / 'yolov7') not in sys.path:
    sys.path.append(str(ROOT / 'yolov7'))  # add yolov5 ROOT to PATH
if str(ROOT / 'strong_sort') not in sys.path:
    sys.path.append(str(ROOT / 'strong_sort'))  # add strong_sort ROOT to PATH
ROOT = Path(os.path.relpath(ROOT, Path.cwd()))  # relative


from yolov7.models.experimental import attempt_load
from yolov7.utils.datasets import LoadImages, LoadStreams
from yolov7.utils.general import (check_img_size, non_max_suppression, scale_coords, check_requirements, cv2,
                                  check_imshow, xyxy2xywh, increment_path, strip_optimizer, colorstr, check_file)
from yolov7.utils.torch_utils import select_device, time_synchronized
from yolov7.utils.plots import plot_one_box
from strong_sort.utils.parser import get_config
from strong_sort.strong_sort import StrongSORT

from django.http import StreamingHttpResponse




VID_FORMATS = 'asf', 'avi', 'gif', 'm4v', 'mkv', 'mov', 'mp4', 'mpeg', 'mpg', 'ts', 'wmv'  # include video suffixes


def gen_frame(frame):
    while True:
        image = frame
        _, jpeg = cv2.imencode('.jpg', image)
        yield(b'--frame\r\n'
            b'Content-Type: image/jpeg\r\n\r\n' + jpeg + b'\r\n\r\n')

class yolo_api:
    def __init__(self,
        source=ROOT / 'test_video.mp4',
        yolo_weights=WEIGHTS / 'yolov5m.pt',  # model.pt path(s),
        strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
        config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
        imgsz=(640, 640),  # inference size (height, width)
        conf_thres=0.25,  # confidence threshold
        iou_thres=0.45,  # NMS IOU threshold
        max_det=1000,  # maximum detections per image
        device='cpu',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
        show_vid=False,  # show results
        save_txt=False,  # save results to *.txt
        save_conf=False,  # save confidences in --save-txt labels
        save_crop=False,  # save cropped prediction boxes
        save_vid=False,  # save confidences in --save-txt labels
        nosave=False,  # do not save images/videos
        classes=None,  # filter by class: --class 0, or --class 0 2 3
        agnostic_nms=False,  # class-agnostic NMS
        augment=False,  # augmented inference
        visualize=False,  # visualize features
        update=False,  # update all models
        project=ROOT / 'runs/track',  # save results to project/name
        name='exp',  # save results to project/name
        exist_ok=False,  # existing project/name ok, do not increment
        line_thickness=3,  # bounding box thickness (pixels)
        hide_labels=False,  # hide labels
        hide_conf=False,  # hide confidences
        hide_class=False,  # hide IDs
        half=False,  # use FP16 half-precision inference
        dnn=False,  # use OpenCV DNN for ONNX inference
        deepsort=False #MOT or not custumized thing
    ):
        self.yolo_weights = yolo_weights
        self.strong_sort_weights = strong_sort_weights
        self.config_strongsort = config_strongsort
        self.source = source
        self.device = device
        self.deepsort = deepsort
        self.classes = classes
        self.project = project
        self.name = name
        self.save_vid = save_vid
        ########################################################
        self.imgsz = imgsz
        self.conf_thres = conf_thres
        self.iou_thres = iou_thres
        self.max_det = max_det
        self.show_vid = show_vid
        self.save_txt = save_txt
        self.save_conf = save_conf
        self.save_crop = save_crop
        self.nosave = nosave
        self.line_thickness = line_thickness
        self.hide_labels = hide_labels
        self.hide_conf = hide_conf
        self.exist_ok = exist_ok
        self.agnostic_nms = agnostic_nms
        self.augment = augment
        self.visualize = visualize
        self.update = update
        self.hide_class = hide_class
        self.half = half
        self.dnn = dnn
        self.imgsz *= 2 if len(self.imgsz) == 1 else 1  # expand


@torch.no_grad()
class yolo_stream(object):
    def __init__(self,**kwargs):
        self.api = yolo_api(**kwargs)
        self.set()
        # self.img

    def set(self):
        self.source = str(self.api.source)
        source = str(self.api.source)
        self.save_img = not self.api.nosave and not source.endswith('.txt')  # save inference images
        self.is_file = Path(self.source).suffix[1:] in (VID_FORMATS)
        self.is_url = self.source.lower().startswith(('rtsp://', 'rtmp://', 'http://', 'https://'))
        self.webcam = source.isnumeric() or source.endswith('.txt') or (self.is_url and not self.is_file)
        if self.is_url and self.is_file:
            self.source = check_file(source)  # download
        self.yolo_weights = self.api.yolo_weights

        # Directories
        if not isinstance(self.yolo_weights, list):  # single yolo model
            self.exp_name = self.yolo_weights.stem
        elif type(self.yolo_weights) is list and len(self.yolo_weights) == 1:  # single models after --yolo_weights
            self.exp_name = Path(self.yolo_weights[0]).stem
            self.yolo_weights = Path(self.yolo_weights[0])
        else:  # multiple models after --yolo_weights
            self.exp_name = 'ensemble'
        self.exp_name = self.api.name if self.api.name else self.exp_name + "_" + self.api.strong_sort_weights.stem
        # save_dir = increment_path(Path(project) / exp_name, exist_ok=exist_ok)  # increment run
        self.save_dir = Path(self.api.project) / self.exp_name  # non-increment run
        self.save_dir = Path(self.save_dir)
        (self.save_dir / 'tracks' if self.api.save_txt else self.save_dir).mkdir(parents=True, exist_ok=True)  # make dir
        print(self.api.conf_thres)
        # Load model
        self.device = select_device(self.api.device)
        
        WEIGHTS.mkdir(parents=True, exist_ok=True)
        self.model = attempt_load(Path(self.yolo_weights), map_location=self.device)  # load FP32 model
        self.names, = self.model.names,
        self.stride = self.model.stride.max()  # model stride
        self.imgsz = check_img_size(self.api.imgsz[0], s=self.stride.cpu().numpy())  # check image size

        # # Dataloader
        # if webcam:
        #     show_vid = check_imshow()
        #     cudnn.benchmark = True  # set True to speed up constant image size inference
        #     dataset = LoadStreams(source, img_size=imgsz, stride=stride.cpu().numpy())
        #     nr_sources = 1
        # else:
        #     dataset = LoadImages(source, img_size=imgsz, stride=stride)
        #     nr_sources = 1
        # vid_path, vid_writer, txt_path = [None] * nr_sources, [None] * nr_sources, [None] * nr_sources
        nr_sources = 1  ######## possible frame unit
        # initialize StrongSORT
        self.cfg = get_config()
        self.cfg.merge_from_file(self.api.config_strongsort)

        # Create as many strong sort instances as there are video sources
        self.strongsort_list = []
        for i in range(nr_sources):
            self.strongsort_list.append(
                StrongSORT(
                    self.api.strong_sort_weights,
                    self.device,
                    self.api.half,
                    max_dist=self.cfg.STRONGSORT.MAX_DIST,
                    max_iou_distance=self.cfg.STRONGSORT.MAX_IOU_DISTANCE,
                    max_age=self.cfg.STRONGSORT.MAX_AGE,
                    n_init=self.cfg.STRONGSORT.N_INIT,
                    nn_budget=self.cfg.STRONGSORT.NN_BUDGET,
                    mc_lambda=self.cfg.STRONGSORT.MC_LAMBDA,
                    ema_alpha=self.cfg.STRONGSORT.EMA_ALPHA,

                )
            )
            self.strongsort_list[i].model.warmup()
        self.outputs = [None] * nr_sources
        
        self.colors = [[random.randint(0, 255) for _ in range(3)] for _ in self.names]
        
        self.curr_frames, self.prev_frames = [None] * nr_sources, [None] * nr_sources
        self.seen = 0

        # print(self.yolo_weights, self.api.deepsort, self.api.yolo_weights)

    def run(self):
        print(self.yolo_weights, self.api.deepsort)
        
        # Dataloader
        if self.webcam:
            show_vid = check_imshow()
            cudnn.benchmark = True  # set True to speed up constant image size inference
            dataset = LoadStreams(self.source, img_size=self.imgsz, stride=self.stride.cpu().numpy())
            nr_sources = 1
        else:
            dataset = LoadImages(self.source, img_size=self.imgsz, stride=self.stride)
            nr_sources = 1
        vid_path, vid_writer, txt_path = [None] * nr_sources, [None] * nr_sources, [None] * nr_sources

        
        # Run tracking
        dt, seen = [0.0, 0.0, 0.0, 0.0], 0
        curr_frames, prev_frames = [None] * nr_sources, [None] * nr_sources
        for frame_idx, (path, im, im0s, vid_cap) in enumerate(dataset):
            s = ''
            t1 = time_synchronized()
            im = torch.from_numpy(im).to(self.device)
            im = im.half() if self.api.half else im.float()  # uint8 to fp16/32
            im /= 255.0  # 0 - 255 to 0.0 - 1.0
            if len(im.shape) == 3:
                im = im[None]  # expand for batch dim
            t2 = time_synchronized()
            dt[0] += t2 - t1

            # Inference
            visualize = increment_path(self.save_dir / Path(path[0]).stem, mkdir=True) if self.api.visualize else False
            pred = self.model(im)
            t3 = time_synchronized()
            dt[1] += t3 - t2

            # Apply NMS
            pred = non_max_suppression(pred[0], self.api.conf_thres, self.api.iou_thres, self.api.classes, self.api.agnostic_nms)
            dt[2] += time_synchronized() - t3
            
            # Process detections
            for i, det in enumerate(pred):  # detections per image
                self.seen += 1
                seen = self.seen -1
                if self.webcam:  # nr_sources >= 1
                    p, im0, _ = path[i], im0s[i].copy(), dataset.count
                    p = Path(p)  # to Path
                    s += f'{i}: '
                    txt_file_name = p.name
                    save_path = str(self.save_dir / p.name)  # im.jpg, vid.mp4, ...
                else:
                    p, im0, _ = path, im0s.copy(), getattr(dataset, 'frame', 0)
                    p = Path(p)  # to Path
                    # video file
                    if self.source.endswith(VID_FORMATS):
                        txt_file_name = p.stem
                        save_path = str(self.save_dir / p.name)  # im.jpg, vid.mp4, ...
                    # folder with imgs
                    elif self.source.endswith('jpg'):
                        txt_file_name = p.stem
                        save_path = str(self.save_dir / p.name)
                    else:
                        txt_file_name = p.parent.name  # get folder name containing current img
                        save_path = str(self.save_dir / p.parent.name)  # im.jpg, vid.mp4, ...

                curr_frames[i] = im0

                txt_path = str(self.save_dir / 'tracks' / txt_file_name)  # im.txt
                s += '%gx%g ' % im.shape[2:]  # print string
                imc = im0.copy() if self.api.save_crop else im0  # for save_crop

                if self.api.deepsort and self.cfg.STRONGSORT.ECC:  # camera motion compensation
                    self.strongsort_list[i].tracker.camera_update(self.prev_frames[i], curr_frames[i])

                if det is not None and len(det):
                    # Rescale boxes from img_size to im0 size
                    det[:, :4] = scale_coords(im.shape[2:], det[:, :4], im0.shape).round()

                    # Print results
                    for c in det[:, -1].unique():
                        n = (det[:, -1] == c).sum()  # detections per class
                        s += f"{n} {self.names[int(c)]}{'s' * (n > 1)}, "  # add to string

                    xywhs = xyxy2xywh(det[:, 0:4])
                    confs = det[:, 4]
                    clss = det[:, 5]

                    # pass detections to strongsort
                    t4 = time_synchronized()
                    if self.api.deepsort:
                        self.outputs[i] = self.strongsort_list[i].update(xywhs.cpu(), confs.cpu(), clss.cpu(), im0)
                    t5 = time_synchronized()
                    dt[3] += t5 - t4

                    # draw boxes for visualization
                    if self.api.deepsort:
                        if len(self.outputs[i]) > 0:
                            for j, (output, conf) in enumerate(zip(self.outputs[i], confs)):
            
                                bboxes = output[0:4]
                                id = output[4]
                                cls = output[5]

                                if self.api.save_txt:
                                    # to MOT format
                                    bbox_left = output[0]
                                    bbox_top = output[1]
                                    bbox_w = output[2] - output[0]
                                    bbox_h = output[3] - output[1]
                                    # Write MOT compliant results to file
                                    with open(txt_path + '.txt', 'a') as f:
                                        f.write(('%g ' * 10 + '\n') % (frame_idx + 1, id, bbox_left,  # MOT format
                                                                    bbox_top, bbox_w, bbox_h, -1, -1, -1, i))

                                if self.api.save_vid or self.api.save_crop or self.api.show_vid:  # Add bbox to image
                                    c = int(cls)  # integer class
                                    id = int(id)  # integer id
                                    label = None if self.api.hide_labels else (f'{id} {self.names[c]}' if self.api.hide_conf else \
                                        (f'{id} {conf:.2f}' if self.hself.api.ide_class else f'{id} {self.names[c]} {conf:.2f}'))
                                    plot_one_box(bboxes, im0, label=label, color=self.colors[int(cls)], line_thickness=self.api.line_thickness)
                            print(f'{s}Done. YOLO:({t3 - t2:.3f}s), StrongSORT:({t5 - t4:.3f}s)')
                        else:
                            self.strongsort_list[i].increment_ages()
                            print('No detections')
                    else:
                        # print(det)
                        for *xyxy, conf, cls in reversed(det):
                            if self.api.save_vid or self.api.show_vid:  # Add bbox to image
                                label = f'{self.names[int(cls)]} {conf:.2f}'
                                plot_one_box(xyxy, im0, label=label, color=self.colors[int(cls)], line_thickness=self.api.line_thickness)
                                print("******************DRAW BOX**********************")

                save_path = str(Path(save_path).with_suffix('.jpg'))
                print(f" The image with the result is saved in: {save_path}")
                cv2.imwrite(save_path, im0)
                print("******************SAVE IMAGE**********************")


                self.prev_frames[i] = curr_frames[i]
                return 0

        # Print results
        t = tuple(x / seen * 1E3 for x in dt)  # speeds per image
        print(f'Speed: %.1fms pre-process, %.1fms inference, %.1fms NMS, %.1fms strong sort update per image at shape {(1, 3, self.imgsz, self.imgsz)}' % t)
        if self.api.save_txt or self.api.save_vid:
            s = f"\n{len(list(self.save_dir.glob('tracks/*.txt')))} tracks saved to {self.save_dir / 'tracks'}" if self.api.save_txt else ''
            print(f"Results saved to {colorstr('bold', self.save_dir)}{s}")
        if self.api.update:
            strip_optimizer(self.yolo_weights)  # update model (to fix SourceChangeWarning)
        return self.save_dir


    def retrunStream(self):
        return StreamingHttpResponse(gen_frame(self.img), content_type="multipart/x-mixed-replace;boundary=frame")

