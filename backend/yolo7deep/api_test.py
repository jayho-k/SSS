from pathlib import Path

FILE = Path(__file__).resolve()
ROOT = FILE.parents[0]  # yolov5 strongsort root directory
WEIGHTS = ROOT / 'weights'

from yolo_api import yolo_detect_api
yolo_detect_api(
source='./test_video.mp4',
yolo_weights=WEIGHTS / 'yolov7.pt',  # model.pt path(s),
strong_sort_weights='./osnet_x0_25_market1501.pt',  # model.pt path,
config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
device='cpu',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
deepsort=False, #MOT or not custumized thing
# yolo_weights=WEIGHTS / 'yolov5m.pt',  # model.pt path(s),
# strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
# config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
# imgsz=(640, 640),  # inference size (height, width)
# conf_thres=0.25,  # confidence threshold
# iou_thres=0.45,  # NMS IOU threshold
# max_det=1000,  # maximum detections per image
# device='',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
# show_vid=False,  # show results
# save_txt=False,  # save results to *.txt
# save_conf=False,  # save confidences in --save-txt labels
# save_crop=False,  # save cropped prediction boxes
# save_vid=False,  # save confidences in --save-txt labels
# nosave=False,  # do not save images/videos
# classes=None,  # filter by class: --class 0, or --class 0 2 3
# agnostic_nms=False,  # class-agnostic NMS
# augment=False,  # augmented inference
# visualize=False,  # visualize features
# update=False,  # update all models
# project=ROOT / 'runs/track',  # save results to project/name
# name='exp',  # save results to project/name
# exist_ok=False,  # existing project/name ok, do not increment
# line_thickness=3,  # bounding box thickness (pixels)
# hide_labels=False,  # hide labels
# hide_conf=False,  # hide confidences
# hide_class=False,  # hide IDs
# half=False,  # use FP16 half-precision inference
# dnn=False,  # use OpenCV DNN for ONNX inference
)