from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from rest_framework.pagination import PageNumberPagination

from core.models import Vehicule
from vehicule.serializer import VehicleSerializer

class VehiclePagination(PageNumberPagination):
    page_size = 200

class VehicleListView(generics.ListAPIView):
    queryset = Vehicule.objects.all().order_by('id')
    serializer_class = VehicleSerializer
    permission_classes = [IsAuthenticated]
    pagination_class = VehiclePagination
