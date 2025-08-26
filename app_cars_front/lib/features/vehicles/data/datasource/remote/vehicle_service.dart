import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:dio/dio.dart';

class VehicleService {
  final Dio _dio;

  VehicleService(this._dio);

  Future<Resource<VehicleResponse>> get(String? url, String token) async {
    try {
      final response = await _dio.get(
        url ?? '/vehicule/',
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        VehicleResponse vehicleResponse = VehicleResponse.fromJson(
          response.data,
        );
        return Success<VehicleResponse>(vehicleResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      print('Error during get: $e');
      return Error('An error occurred during get: ${e.toString()}');
    }
  }
}
