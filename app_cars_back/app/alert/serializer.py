from rest_framework import serializers

from core.models import Alert, Vehicule
from vehicule.serializer import VehicleSerializer


class AlertSerializer(serializers.ModelSerializer):
    vehicle = VehicleSerializer(read_only=True)

    class Meta:
        model = Alert
        fields = ['id', 'level', 'message', 'created_at', 'vehicle']
