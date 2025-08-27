import 'package:app_cars_front/core/db/app_database.dart';
import 'package:app_cars_front/features/auth/data/datasource/local/models/user_dao.dart';
import 'package:get_it/get_it.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final UsersDao _dao;
  final NetworkInfo _networkInfo;

  final ISecureStorageService _secureStorage = GetIt.I<ISecureStorageService>();

  AuthRepositoryImpl(this._authService, this._dao, this._networkInfo);

  @override
  Future<Resource<AuthResponse>> login() async {
    var token = await _secureStorage.read(SecureStorageConstants.token);
    if (token == null) {
      return Error('No token found');
    }

    /// Check network connectivity
    if (await _networkInfo.isConnected) {
      /// Fetch user data
      return await _authService.login(token);
    } else {
      print('No internet connection, fetching local user');
      return _getResourceUser();
    }
  }

  @override
  Future<bool> logout() async {
    await Future.wait([
      /// Clear user data from local database.
      _dao.clearUser(),

      /// Clear user data from secure storage.
      _secureStorage.deleteAll(),
    ]);

    return true;
  }

  @override
  Future<Resource<TokenResponse>> getToken(String account, String phone) async {
    /// Check network connectivity
    if (await _networkInfo.isConnected) {
      return await _authService.getToken(account, phone);
    } else {
      print('No internet connection, fetching local token');

      /// Fetch local token, if exists send it else return error.
      var token = await _secureStorage.read(SecureStorageConstants.token);
      if (token == null) {
        return Error('No token found');
      }

      return Success(TokenResponse(token: token));
    }
  }

  @override
  Future<bool> saveUserSession(
    String account,
    String phone,
    String token,
  ) async {
    await Future.wait([_saveUserInSecureStorage(account, phone, token)]);
    return true;
  }

  /// Save user data in secure storage.
  Future<void> _saveUserInSecureStorage(
    String account,
    String phone,
    String token,
  ) async {
    await Future.wait([
      // Save user data in secure storage.
      _secureStorage.write(SecureStorageConstants.account, account),
      _secureStorage.write(SecureStorageConstants.phone, phone),
      _secureStorage.write(SecureStorageConstants.token, token),

      /// Save user data in local database.
      _saveUserInLocal(account, phone),
    ]);
  }

  /// Save user data in local database.
  Future<void> _saveUserInLocal(String account, String phone) async {
    await _dao.clearUser();
    await _dao.insertUser(
      UsersCompanion.insert(account: account, phone: phone),
    );
  }

  /// Get user from local database and return as Resource.
  Future<Resource<AuthResponse>> _getResourceUser() async {
    final localUser = await _getLocalUser();
    print('Local user: $localUser');
    if (localUser != null) {
      return Success(localUser);
    } else {
      return Error('No local user found');
    }
  }

  /// Get user from local database and return as AuthResponse.
  Future<AuthResponse?> _getLocalUser() async {
    try {
      final localUser = await _dao.getUser();

      if (localUser == null) return null;
      return AuthResponse(account: localUser.account, phone: localUser.phone);
    } catch (e) {
      return null;
    }
  }
}
