import 'package:get_it/get_it.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final ISecureStorageService _secureStorage = GetIt.I<ISecureStorageService>();

  AuthRepositoryImpl(this._authService);

  @override
  Future<Resource<AuthResponse>> login() async {
    // Not implemented
    return Error('Login not implemented');
  }

  @override
  Future<bool> logout() async {
    // Not implemented
    return false;
  }

  @override
  Future<Resource<TokenResponse>> getToken(String account, String phone) async {
    return await _authService.getToken(account, phone);
  }
}
