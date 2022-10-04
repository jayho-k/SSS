
import string
import secrets
from backend.common import checkuser
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import BlacklistedToken, OutstandingToken
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.hashers import check_password
from django.db.models import Q
from .serializers import (
    UserSignupSerializer, 
    UserActiveSeriailzer, 
    UserDetailSerializer,
    UserListSerializer,
)

@api_view(["POST"])
def login(request):
    username=request.data.get("username")
    password=request.data.get("password")
    user = get_user_model().objects.get(username=username)
    
    if user is not None and check_password(password, user.password):
        if user.activation==True:
            token = TokenObtainPairSerializer.get_token(user)
            refresh_token = str(token)
            access_token = str(token.access_token)
            data = {
                "refresh": refresh_token,
                "access": access_token,
                "is_admin" : user.is_admin
            }
            return Response(data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
    return Response(status=status.HTTP_403_FORBIDDEN)


# 로그아웃
@api_view(["POST"])
def logout(request):
    if request.method == "POST":
        token = request.META.get("HTTP_AUTHORIZATION")
        user_id = checkuser(token)
        tokens = OutstandingToken.objects.filter(user_id=user_id)
        if tokens is not None:
            for token in tokens:
                t, _ = BlacklistedToken.objects.get_or_create(token=token)
                token.delete()
            return Response(status=status.HTTP_200_OK)
        return Response(status=status.HTTP_401_UNAUTHORIZED)

# 회원가입 신청
@api_view(["POST"])
def signup(request):
    if request.method == "POST":
        user = UserSignupSerializer(data=request.data)
        if user.is_valid(raise_exception=True):
            user.save()
            return Response(status=status.HTTP_201_CREATED)
    return Response(status=status.HTTP_403_FORBIDDEN)

        


@api_view(["GET", "PUT", "DELETE"])
def user_detail_or_update_or_delete(request):
    token = request.META.get("HTTP_AUTHORIZATION")
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
        if user.is_admin == False:
            tokens = OutstandingToken.objects.filter(user_id=user_id)
            if tokens is not None:
                for token in tokens:
                    token.delete()
            user.delete()
            return Response(status=status.HTTP_200_OK)
        msg = {
            "message": "관리자는 삭제할 수 없습니다."
        }
        return Response(msg,status=status.HTTP_403_FORBIDDEN)
    return Response(status=status.HTTP_403_FORBIDDEN)

# 비밀번호 변경
# curr_password가 기존 비밀번호와 일치히면 new_password로 변경
@api_view(["PUT"])
def password_change(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    user_id = checkuser(token)
    user = get_object_or_404(get_user_model(), id=user_id)
    curr_password = request.data.get("curr_password")
    new_password = request.data.get("new_password")

    if check_password(curr_password, user.password):
        user.set_password(new_password)
        user.save()
        return Response(status=status.HTTP_200_OK)
    return Response(status=status.HTTP_403_FORBIDDEN)

# 아이디 찾기
# email과 name이 일치하는 username반환
@api_view(["POST"])
def find_id(request):
    name = request.data.get("name")
    email = request.data.get("email")
    user = get_object_or_404(get_user_model(),name=name, email=email)
    data = {
        "username" : user.username
    }
    return Response(data, status=status.HTTP_200_OK)

# 비밀번호 초기화 요청
# @api_view(["POST"])
# def password_find(request):
#     name = request.data.get("name")
#     email = request.data.get("email")
#     username = request.data.get("username")
#     user = get_object_or_404(get_user_model(),username=username, name=name, email=email)
#     user.forget_password = True
#     user.save()
#     return Response(status=status.HTTP_200_OK)
    
    
###############################관리자 영역##########################################
# 비밀번호 초기화
# 유저가 비밀번호 찾기 요청을 보내면 관리자가 임시비밀번호 반환
# KISA(한국인터넷진흥원)에서 가이드하는 안전한 패스워드 정책(2가지 이상의 문자열을 대소문자조합 그리고 10자리 이상)
@api_view(["POST"])
def password_reset(request):
    user_id = request.data.get("uid")
    user = get_object_or_404(get_user_model(), id=user_id)
    # if (user.forget_password == True):
    string_pool = string.ascii_letters + string.digits
    while True:
        temp_password = ''.join(secrets.choice(string_pool) for i in range(10))
        if (any(c.islower() for c in temp_password)
            and any(c.isupper() for c in temp_password)
            and sum(c.isdigit() for c in temp_password) >= 3):
            break
    data = {
        "password" : temp_password
    }
    user.set_password(temp_password)
    from django.core.mail import EmailMessage
    from django.template.loader import render_to_string

    mail_subject = 'smtp를 사용하여 이메일 보내기'
    message = render_to_string('smtp_email.html', {
        "name" : user.name,
        "password" : temp_password
        })
    to_email = user.email
    send_email = EmailMessage(mail_subject, message, to=[to_email])
    send_email.send()
    user.forget_password = False
    user.save()
    return Response(data, status=status.HTTP_200_OK)
    # return Response(status=status.HTTP_200_OK)

# 회원가입 승인    
@api_view(['PATCH'])
def user_activate(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    admin_id = checkuser(token)
    admin = get_object_or_404(get_user_model(), id=admin_id)
    user = get_object_or_404(get_user_model(), id=request.data.get("uid"))
    if (admin.is_admin):
        if request.method == "PATCH":
            user.activation = 1
            user.save()
            return Response(status=status.HTTP_200_OK)
    else:
        return Response(status=status.HTTP_401_UNAUTHORIZED)

# Activation = True인 유저 리스트
@api_view(["GET"])
def user_activate_list(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    admin_id = checkuser(token)
    admin = get_object_or_404(get_user_model(), id=admin_id)
    if (admin.is_admin):
        if request.method == "GET":
            users = get_user_model().objects.filter(activation=1, is_admin=False)
            serializers = UserListSerializer(users, many=True)
            return Response(serializers.data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_403_FORBIDDEN)
    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# Activation = False인 유저 리스트
@api_view(["GET"])
def user_deactivate_list(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    admin_id = checkuser(token)
    admin = get_object_or_404(get_user_model(), id=admin_id)
    if (admin.is_admin):
        if request.method == "GET":
            users = get_user_model().objects.filter(activation=0, is_admin=False)
            serializers = UserListSerializer(users, many=True)
            return Response(serializers.data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_403_FORBIDDEN)
    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# 유저 검색
@api_view(["POST"])
def user_search(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    admin_id = checkuser(token)
    admin = get_object_or_404(get_user_model(), id=admin_id)
    res = request.data.get("search")
    if (admin.is_admin):
        if request.method == "POST":
            search_user = get_user_model().objects.filter(Q(name__contains=res) | Q(email__contains=res))
            serializers = UserListSerializer(search_user, many=True)
            return Response(serializers.data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_403_FORBIDDEN)
    return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(["DELETE"])
def user_delete(request):
    token = request.META.get("HTTP_AUTHORIZATION")
    admin_id = checkuser(token)
    admin = get_object_or_404(get_user_model(), id=admin_id)
    user = get_object_or_404(get_user_model(), id=request.data.get("uid"))
    if (admin.is_admin):
        if request.method == "DELETE":
            user.delete()
            return Response(status=status.HTTP_200_OK)
    else:
        return Response(status=status.HTTP_401_UNAUTHORIZED)


   


        
        
        
