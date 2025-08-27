from datetime import datetime, timedelta
import random

from rest_framework.views import APIView
from rest_framework.response import Response

from core.models import User, Vehicule, Alert, Place


# Create a seed view to load data.
class SeedView(APIView):

    def post(self, request):

        # Create user admin if not exists.
        if not User.objects.filter(account='admin').exists():
            User.objects.create_superuser(account='admin', password='root1234')

        # Create demo user if not exists.
        if not User.objects.filter(account='supervisor').exists():
            User.objects.create_user(
                account='supervisor', phone='123456789', password='root1234'
            )

        # Reset models.
        Vehicule.objects.all().delete()
        Place.objects.all().delete()
        Alert.objects.all().delete()

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

        # Create alerts for each vehicle.
        now = datetime.utcnow()
        vehicles = list(Vehicule.objects.all())
        alerts = []

        for _ in range(300):
            v = random.choice(vehicles)
            dt = now - timedelta(days=random.randint(0, 7), hours=random.randint(0, 23))
            alerts.append(Alert(vehicle=v, level=random.randint(0, 7), created_at=dt))
        Alert.objects.bulk_create(alerts)


        # Create places
        storages_names = ["Taller Central", "Taller Norte", "Taller Sur", "Taller Este", "Taller Oeste"]
        notes = ["Lugar de servicio", "Punto de control", "Zona de riesgo"]
        places = []
        for i in range(20):
            places.append(
                Place(
                    name=random.choice(storages_names),
                    latitude=-12.0 + random.random()*10,
                    longitude=-77.0 + random.random()*10,
                    phone=f"123456789{i}",
                    notes=random.choice(notes)
                ))
        Place.objects.bulk_create(places)

        return Response({"message": "Datos de prueba cargados"}, status=201)
