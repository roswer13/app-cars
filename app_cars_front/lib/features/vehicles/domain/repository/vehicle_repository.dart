import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

abstract class VehicleRepository {
  Future<Resource<VehicleResponse>> get(String? url);
}
