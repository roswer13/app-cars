import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';

class DeleteAllVehiclesUseCase {
  VehicleRepository repository;

  DeleteAllVehiclesUseCase(this.repository);

  run() async {
    return await repository.deleteAll();
  }
}
