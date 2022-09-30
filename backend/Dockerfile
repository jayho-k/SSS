FROM python:3.8.10

ENV PYTHONUNBUFFERED=1

WORKDIR /jenkins_home/workspace/b302/backend
COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN mim install mmcv-full
RUN mim install mmdet

WORKDIR /jenkins_home/workspace/b302/backend/mmaction2
RUN pip install -e .

WORKDIR /jenkins_home/workspace/b302/backend
VOLUME /home/ubuntu/S07P22B302/etc/media:/jenkins_home/workspace/b302/backend/media

RUN apt-get update
RUN apt-get install -y libgl1
RUN apt-get install -y vim

CMD ["bash", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]