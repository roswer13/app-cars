import 'package:app_cars_front/core/db/app_database.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/data/models/vehicles.dart';
import 'package:drift/drift.dart';

part 'vehicle_dao.g.dart';

@DriftAccessor(tables: [Vehicles])
class VehiclesDao extends DatabaseAccessor<AppDatabase>
    with _$VehiclesDaoMixin {
  VehiclesDao(AppDatabase db) : super(db);

  Future<List<Vehicle>> getAllVehicles() => select(vehicles).get();

  Future<void> insertVehicles(List<VehiclesCompanion> vehiclesList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(vehicles, vehiclesList);
    });
  }

  Future<void> clearVehicles() async {
    await delete(vehicles).go();
  }
}
