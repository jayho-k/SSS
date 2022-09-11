from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import (
    UserSignupSerializer, 
    UserActiveSeriailzer, 
    UserDetailSerializer,
)
import jwt
from backend.settings import SIMPLE_JWT   

# access 토큰을 통한 유저 확인 => user_id값 반환
def checkuser(token):
    # header에서 받은 token 내용에 선행값 (ex. Bearer)이 있다면 token값이랑 분리 시켜준다.
    # "bearer 토큰값"
    type, jwt_token = token.split(' ')
    user_token = jwt.decode(
    jwt_token,
    SIMPLE_JWT['SIGNING_KEY'],
    algorithms=[SIMPLE_JWT['ALGORITHM']],
    )
    return user_token["user_id"]


# # 로그아웃
# @api_view(["GET"])
# def logout(request):
#     pass

# 회원가입 신청
@api_view(["POST"])
def signup(request):
    if request.method == "POST":
        user = UserSignupSerializer(data=request.data)
        if user.is_valid(raise_exception=True):
            user.save()
            return Response(status=status.HTTP_201_CREATED)

        
# 회원가입 승인    
@api_view(['PATCH'])
def user_activate(request):
    token = request.META.get('HTTP_AUTHORIZATION')
    user_id = checkuser(token)
    user = get_user_model().objects.get(id=user_id)
    if request.method == "PATCH":
        serializer = UserActiveSeriailzer(instance=user, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(status=status.HTTP_200_OK)


@api_view(["GET", "PUT","DELETE"])
def user_detail_or_update_delete(request):
    token = request.META.get('HTTP_AUTHORIZATION')
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    # 유저 상세정보
    if request.method == "GET":
        serializer = UserDetailSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)
    # 유저 정보 수정
    elif request.method == "PUT":
        serializer = UserDetailSerializer(instance=user, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(status=status.HTTP_200_OK)
    # 회원 탈퇴(비활성화)
    elif request.method == "DELETE":
        serializer = UserActiveSeriailzer(instance=user, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(status=status.HTTP_200_OK)

# 비밀번호 변경
@api_view(["POST"])
def password_change(request):
    pass

# 아이디 찾기
@api_view(["POST"])
def find_id(request):
    pass

# 비밀번호 초기화
@api_view(["POST"])
def password_reset(request):
    pass

# Activation = True인 유저 리스트
@api_view(["GET"])
def user_activate_list(request):
    pass

# Activation = False인 유저 리스트
@api_view(["GET"])
def user_deactivate_list(request):
    pass

# 유저 검색
@api_view(["POST"])
def user_search(request):
    pass


   


        
        
        
