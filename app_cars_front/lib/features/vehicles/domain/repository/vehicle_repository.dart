import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';

abstract class VehicleRepository {
  Future<Resource<VehicleResponse>> get(String? url);

  Future<Resource<List<VehicleResult>>> getAll(bool refresh);
}
