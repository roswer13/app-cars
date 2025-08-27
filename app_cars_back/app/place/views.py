from rest_framework import generics, authentication, permissions

from core.models import Place
from place.serializer import PlaceSerializer


class PlaceListView(generics.ListAPIView):
    queryset = Place.objects.all().order_by('id')
    serializer_class = PlaceSerializer
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
