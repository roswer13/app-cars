import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISecureStorageService {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

class SecureStorage implements ISecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  @override
  Future<void> write(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<String?> read(String key) async {
    return await _storage.read(
      key: key,
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(
      key: key,
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll(
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}
