import 'package:app_cars_front/core/db/app_database.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';

import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/data/models/vehicle_dao.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/remote/vehicle_service.dart';
import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';
import 'package:app_cars_front/core/core.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleService _vehicleService;
  final VehiclesDao dao;
  final ISecureStorageService _secureStorage = GetIt.I<ISecureStorageService>();

  VehicleRepositoryImpl(this._vehicleService, this.dao);

  @override
  Future<Resource<VehicleResponse>> get(String? url) async {
    var token = await _secureStorage.read(SecureStorageConstants.token);
    if (token == null) {
      return Error('No token found');
    }

    return await _vehicleService.get(url, token);
  }

  @override
  Future<Resource<List<VehicleResult>>> getAll(bool refresh) async {
    var dbVehicles = await dao.getAllVehicles();

    if (refresh || dbVehicles.isEmpty) {
      var token = await _secureStorage.read(SecureStorageConstants.token);
      if (token == null) {
        return Error('No token found');
      }

      final Resource<VehicleResponse> response = await _vehicleService.get(
        null,
        token,
      );

      if (response is Success<VehicleResponse>) {
        print('Vehicles: ${response.data.results.length}');
        // Cache the vehicles in the local database
        await dao.clearVehicles();
        final companions = response.data.results.map((v) {
          return VehiclesCompanion.insert(
            id: Value(v.id),
            plate: v.plate,
            label: v.label,
            statusColor: v.statusColor,
            latitude: v.latitude,
            longitude: v.longitude,
          );
        }).toList();
        await dao.insertVehicles(companions);
      }
    }

    dbVehicles = await dao.getAllVehicles();
    final vehicleResults = dbVehicles
        .map(
          (e) => VehicleResult(
            id: e.id,
            plate: e.plate,
            label: e.label,
            statusColor: e.statusColor,
            latitude: e.latitude,
            longitude: e.longitude,
          ),
        )
        .toList();
    print('Vehicles: ${vehicleResults.length}');
    return Success(vehicleResults);
  }
}
