import random

from rest_framework.views import APIView
from rest_framework.response import Response

from core.models import User, Vehicule


# Create a seed view to load data.
class SeedView(APIView):

    def post(self, request):

        # Create user admin if not exists.
        if not User.objects.filter(account='admin').exists():
            User.objects.create_superuser(account='admin', password='123456')

        # Create demo user if not exists.
        if not User.objects.filter(account='supervisor').exists():
            User.objects.create_user(
                account='supervisor', phone='123456789', password='123456'
            )

        # Reset models.
        Vehicule.objects.all().delete()

        plates = [f"ABC{n:03d}" for n in range(1, 1000)]
        colors = [COLOR_CHOICES[0] for COLOR_CHOICES in Vehicule.COLOR_CHOICES]

        # Create vehicle instances.
        vehicles = []
        for plate in plates:
            v = Vehicule(
                plate=plate,
                label=f"Unidad {plate[-3:]}",
                status_color=random.choice(colors),
                latitude=-12.0 + random.random()*10,
                longitude=-77.0 + random.random()*10,
            )
            vehicles.append(v)
        # Insert the new vehicles into the database.
        Vehicule.objects.bulk_create(vehicles)

        return Response({"message": "Datos de prueba cargados"}, status=201)
