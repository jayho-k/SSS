import datetime
import os
from uuid import uuid4
from django.utils import timezone
import jwt
from rest_framework.response import Response
from .settings import SIMPLE_JWT
from rest_framework import status

def file_upload_path(instance, filename):
    # ext = filename.split(".")[-1]
    # d = datetime.datetime.now()
    # filepath = d.strftime("%Y/%m/%d")
    # suffix = d.strftime("%Y%m%d%H%M%S")
    # filename = "%%S_%%S.%%S" % (uuid.uuid4().hex, suffix, ext)
    # return os.path.join(filepath, filename)
    ymd_path = timezone.now().strftime('%Y/%m/%d') 
    # 길이 32 인 uuid 값
    uuid_name = uuid4().hex
    # 확장자 추출
    extension = os.path.splitext(filename)[-1].lower()
    # 결합 후 return
    return '/'.join([
        ymd_path,
        uuid_name + extension,
    ])



def checkuser(token):
    if token is None:
        return Response(status=status.HTTP_401_UNAUTHORIZED) 
    # header에서 받은 token 내용에 선행값 (ex. Bearer)이 있다면 token값이랑 분리 시켜준다.
    # "bearer 토큰값"
    type, jwt_token = token.split(' ')
    user_token = jwt.decode(
    jwt_token,
    SIMPLE_JWT.get("SIGNING_KEY"),
    algorithms=[SIMPLE_JWT.get("ALGORITHM")],
    )
    return user_token.get("user_id")