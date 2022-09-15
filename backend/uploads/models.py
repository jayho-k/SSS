# from django.db import models
# from backend.common import file_upload_path
# from django.conf import settings
# # Create your models here.
# class Upload(models.Model):
#     user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
#     create_at = models.DateTimeField(auto_now_add=True)
#     detection_class = models.CharField(max_length=5)

# class ChildData(models.Model):
#     upload = models.ForeignKey(Upload, on_delete=models.CASCADE)
#     child_class = models.TextField()
    
# class Result(models.Model):
#     user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
#     upload = models.ForeignKey(Upload, on_delete=models.CASCADE, related_name='results') 
#     result_img = models.FileField(upload_to=file_upload_path)
#     time = models.DateTimeField(auto_now_add=True)
#     result_class = models.CharField(max_length=5)
