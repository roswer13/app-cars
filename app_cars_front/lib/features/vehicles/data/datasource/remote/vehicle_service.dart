import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:dio/dio.dart';

class VehicleService {
  final Dio _dio;

  VehicleService(this._dio);

  Future<Resource<VehicleResponse>> get(String token, int page) async {
    print('Fetching vehicles for page $page with token $token');
    try {
      final response = await _dio.get(
        '/vehicule/',
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      print('Response status: ${response.statusCode}');
      print('Options url: ${response.requestOptions.uri}');

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
