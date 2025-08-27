from rest_framework import generics, authentication, permissions

from core.models import Alert
from alert.serializer import AlertSerializer

class AlertListView(generics.ListAPIView):
    queryset = Alert.objects.all().order_by('id')
    serializer_class = AlertSerializer
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
