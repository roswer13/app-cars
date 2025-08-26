from rest_framework import serializers

from core.models import Vehicule


class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicule
        fields = '__all__'
