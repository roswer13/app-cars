import 'package:get_it/get_it.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleService _vehicleService;
  final ISecureStorageService _secureStorage = GetIt.I<ISecureStorageService>();

  VehicleRepositoryImpl(this._vehicleService);

  @override
  Future<Resource<VehicleResponse>> get() async {
    var token = await _secureStorage.read(SecureStorageConstants.token);
    if (token == null) {
      return Error('No token found');
    }

    return await _vehicleService.get(token, 0);
  }
}
