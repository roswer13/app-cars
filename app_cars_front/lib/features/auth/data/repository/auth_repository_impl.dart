import 'package:get_it/get_it.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final ISecureStorageService _secureStorage = GetIt.I<ISecureStorageService>();

  AuthRepositoryImpl(this._authService);

  @override
  Future<Resource<AuthResponse>> login() async {
    var token = await _secureStorage.read(SecureStorageConstants.token);
    if (token == null) {
      return Error('No token found');
    }
    return await _authService.login(token);
  }

  @override
  Future<bool> logout() async {
    await _secureStorage.deleteAll();
    return true;
  }

  @override
  Future<Resource<TokenResponse>> getToken(String account, String phone) async {
    return await _authService.getToken(account, phone);
  }

  @override
  Future<bool> saveUserSession(
    String account,
    String phone,
    String token,
  ) async {
    await _secureStorage.write(SecureStorageConstants.account, account);
    await _secureStorage.write(SecureStorageConstants.phone, phone);
    await _secureStorage.write(SecureStorageConstants.token, token);
    return true;
  }
}
