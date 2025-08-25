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
        '/user/token/',
        data: {"account": account, "phone": phone, "password": "root1234"},
      );

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

  Future<Resource<AuthResponse>> login(String token) async {
    try {
      final response = await _dio.get(
        '/user/me/',
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        return Success<AuthResponse>(authResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during login: $e');
      return Error('An error occurred during login: ${e.toString()}');
    }
  }
}
