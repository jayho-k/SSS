FROM python:3.8.10

ENV PYTHONUNBUFFERED=1

WORKDIR /jenkins_home/workspace/b302/backend
COPY requirements.txt ./

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN apt-get update
RUN apt-get install -y libgl1
RUN apt-get install -y vim

CMD ["bash", "-c", "python manage.py runserver 0.0.0.0:8000"]