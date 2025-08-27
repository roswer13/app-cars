"""
URL mappings for the user API.
"""
from django.urls import path

from alert import views


app_name = 'alert'

urlpatterns = [
    path('', views.AlertListView.as_view(), name='list'),
]
