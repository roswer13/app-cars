import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';

class GetVehiclesUseCase {
  VehicleRepository repository;

  GetVehiclesUseCase(this.repository);

  run(bool refresh) async {
    return await repository.getAll(refresh);
  }
}
