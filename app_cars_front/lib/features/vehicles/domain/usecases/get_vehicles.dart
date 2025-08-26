import 'package:app_cars_front/features/features.dart';

class GetVehiclesUseCase {
  VehicleRepository repository;

  GetVehiclesUseCase(this.repository);

  run() async {
    return await repository.get();
  }
}
