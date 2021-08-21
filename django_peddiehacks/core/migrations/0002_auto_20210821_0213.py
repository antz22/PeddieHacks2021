# Generated by Django 3.2.6 on 2021-08-21 02:13

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Alert',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('head_line', models.CharField(blank=True, max_length=64, null=True)),
                ('content', models.CharField(max_length=128)),
                ('recipient', models.CharField(max_length=64)),
            ],
        ),
        migrations.CreateModel(
            name='Report',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(blank=True, max_length=64, null=True)),
                ('location', models.CharField(blank=True, max_length=64, null=True)),
                ('severity', models.IntegerField(default=0)),
                ('picture', models.ImageField(blank=True, null=True, upload_to='uploads/')),
            ],
        ),
        migrations.CreateModel(
            name='ReportType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=128)),
            ],
        ),
        migrations.DeleteModel(
            name='DummyModel',
        ),
        migrations.AddField(
            model_name='user',
            name='role',
            field=models.CharField(default='student', max_length=64),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='report',
            name='report_type',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='core.reporttype'),
        ),
        migrations.AddField(
            model_name='report',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reports', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='alert',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='alerts', to=settings.AUTH_USER_MODEL),
        ),
    ]
