"""
URL mappings for the user API.
"""
from django.urls import path

from vehicule import views


app_name = 'vehicule'

urlpatterns = [
    path('', views.VehicleListView.as_view(), name='list'),
]
