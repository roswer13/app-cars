import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';

class GetVehiclesUseCase {
  VehicleRepository repository;

  GetVehiclesUseCase(this.repository);

  run(String? url) async {
    return await repository.getAll(false);
  }
}
