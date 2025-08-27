"""
URL mappings for the user API.
"""
from django.urls import path

from place import views


app_name = 'place'

urlpatterns = [
    path('', views.PlaceListView.as_view(), name='list'),
]
