from rest_framework import generics, authentication, permissions
from rest_framework.pagination import PageNumberPagination

from core.models import Vehicule
from vehicule.serializer import VehicleSerializer

class VehiclePagination(PageNumberPagination):
    page_size = 200

class VehicleListView(generics.ListAPIView):
    queryset = Vehicule.objects.all().order_by('id')
    serializer_class = VehicleSerializer
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    pagination_class = VehiclePagination
