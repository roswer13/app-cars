"""
Vehicule model.
"""
from django.db import models


class Vehicule(models.Model):
    """Vehicule in the system."""
    COLOR_CHOICES = [
        ('black', 'Negro'),
        ('red', 'Rojo'),
        ('blue', 'Azul'),
        ('green', 'Verde'),
    ]

    plate = models.CharField(max_length=16, unique=True)
    label = models.CharField(max_length=64, blank=True)
    status_color = models.CharField(
        max_length=8,
        choices=COLOR_CHOICES,
        default='green'
    )
    latitude = models.DecimalField(
        max_digits=9, decimal_places=6,
        null=True, blank=True
    )
    longitude = models.DecimalField(
        max_digits=9, decimal_places=6,
        null=True, blank=True
    )
    last_update = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.plate} ({self.label})"
