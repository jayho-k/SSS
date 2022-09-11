from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import (
    UserSignupSerializer, 
    UserActiveSeriailzer, 
    # UserListSerializer
)
        
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
    import jwt
    from backend.settings import SIMPLE_JWT

    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjYyODYxNDg5LCJpYXQiOjE2NjI4NTc4ODksImp0aSI6IjgwOTUyZTRjZDAyZjQwODQ4ZGY5MTE5OTNmMWU4YjhlIiwidXNlcl9pZCI6Mn0.9MYxTahWY52p1R1vFmxYUBH9dSIZPF94VcTlhRW3MMM"
    user_token = jwt.decode(
    token,
    SIMPLE_JWT['SIGNING_KEY'],
    algorithms=[SIMPLE_JWT['ALGORITHM']],
    )
    user = get_user_model().objects.get(id=user_token["user_id"])
    if request.method == "PATCH":
        serializer = UserActiveSeriailzer(instance=user, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response(status=status.HTTP_200_OK)


# @api_view(["GET", "PUT","DELETE"])
# def user_detail_or_update_delete(request):
#     # 유저 상세정보
#     if request.method == "GET":
#         pass
#     # 유저 정보 수정
#     elif request.method == "PUT":
#         pass
#     # 유저 삭제(비활성화)
#     elif request.method == "DELETE":
#         pass

# # 비밀번호 변경
# @api_view(["POST"])
# def password_change(request):
#     pass

# # 아이디 찾기
# @api_view(["POST"])
# def find_id(request):
#     pass

# # 비밀번호 초기화
# @api_view(["POST"])
# def password_reset(request):
#     pass

# # Activation = True인 유저 리스트
# @api_view(["GET"])
# def user_activate_list(request):
#     pass

# # Activation = False인 유저 리스트
# @api_view(["GET"])
# def user_deactivate_list(request):
#     pass

# # 유저 검색
# @api_view(["POST"])
# def user_search(request):
#     pass


   


        
        
        
