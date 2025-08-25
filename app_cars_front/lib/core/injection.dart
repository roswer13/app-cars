import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/core/injection.config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(Env envConfig) async {
  await locator.init();

  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  locator.registerLazySingleton<ISecureStorageService>(
    () => SecureStorage(locator<FlutterSecureStorage>()),
  );
}
