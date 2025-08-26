import 'package:app_cars_front/core/db/app_database.dart';
import 'package:drift/drift.dart';

extension VehicleMapper on Vehicle {
  /// Convierte modelo de dominio -> Companion para DB
  VehiclesCompanion toCompanion() {
    return VehiclesCompanion.insert(
      id: Value(id),
      plate: plate,
      label: label,
      statusColor: statusColor,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
