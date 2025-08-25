import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

abstract class AuthRepository {
  Future<Resource<AuthResponse>> login();

  Future<bool> logout();

  Future<Resource<TokenResponse>> getToken(String account, String phone);
}
