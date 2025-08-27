"""
Alert model.
"""
from django.db import models
from core.models import Vehicule


class Alert(models.Model):
    vehicle = models.ForeignKey(Vehicule, on_delete=models.CASCADE, related_name="alerts")
    created_at = models.DateTimeField(auto_now_add=True)
    message = models.TextField()
    level = models.IntegerField(default=0)

    def __str__(self):
        return f"Alerta {self.id} - {self.vehicle.plate}"
