FROM python:3.8.10

ENV PYTHONUNBUFFERED=1

WORKDIR /jenkins_home/workspace/b302/backend
COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN mim install mmcv-full
RUN mim install mmdet

RUN git clone https://github.com/open-mmlab/mmaction2.git

WORKDIR /jenkins_home/workspace/b302/backend/mmaction2
RUN pip install -e .

WORKDIR /jenkins_home/workspace/b302/backend

RUN apt-get update
RUN apt-get install -y libgl1
RUN apt-get install -y python3-opencv
RUN apt-get install -y ffmpeg x264 libx264-dev
RUN apt-get install -y vim

CMD ["bash", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]