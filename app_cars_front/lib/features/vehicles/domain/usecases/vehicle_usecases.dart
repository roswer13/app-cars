import 'package:app_cars_front/features/vehicles/domain/usecases/delete_all_vehicle.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/get_vehicles.dart';

class VehicleUseCases {
  GetVehiclesUseCase getVehicles;
  DeleteAllVehiclesUseCase deleteAllVehicles;

  VehicleUseCases({required this.getVehicles, required this.deleteAllVehicles});
}
