# Generated by Django 3.2.15 on 2022-09-16 01:36

import backend.common
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Child',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('child_img', models.ImageField(null=True, upload_to=backend.common.file_upload_path)),
                ('missing_time', models.DateTimeField(auto_now_add=True)),
                ('age', models.IntegerField()),
                ('name', models.CharField(max_length=10)),
                ('find', models.BooleanField(default=False)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
