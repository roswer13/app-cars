import 'package:dio/dio.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Resource<TokenResponse>> getToken(String account, String phone) async {
    try {
      print('Attempting to get token for account: $account and phone: $phone');

      final response = await _dio.post(
        'user/token/',
        data: {"account": account, "phone": phone},
      );

      print('Response status: ${response}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        TokenResponse authResponse = TokenResponse.fromJson(response.data);
        return Success<TokenResponse>(authResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during getToken: $e');
      return Error('An error occurred during getToken: ${e.toString()}');
    }
  }
}
