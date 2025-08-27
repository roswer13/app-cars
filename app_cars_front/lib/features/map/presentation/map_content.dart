import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapContent extends StatelessWidget {
  final List<VehicleResult> vehicles;

  const MapContent({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _getCameraPosition(),
      markers: _getMarkers(vehicles),
      myLocationEnabled: true,
      zoomControlsEnabled: true,
    );
  }
}

CameraPosition _getCameraPosition() {
  return CameraPosition(target: LatLng(-9.189967, -75.015152), zoom: 8);
}

Set<Marker> _getMarkers(List<VehicleResult> vehicles) {
  return vehicles.map((vehicle) {
    return Marker(
      markerId: MarkerId(vehicle.id.toString()),
      position: LatLng(
        double.parse(vehicle.latitude),
        double.parse(vehicle.longitude),
      ),
      infoWindow: InfoWindow(title: vehicle.label, snippet: vehicle.plate),
    );
  }).toSet();
}
