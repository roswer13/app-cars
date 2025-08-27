import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/core/db/app_database.dart';
import 'package:app_cars_front/features/auth/data/datasource/local/models/user_dao.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/data/models/vehicle_dao.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/remote/vehicle_service.dart';
import 'package:app_cars_front/features/vehicles/data/repository/vehicle_repository_impl.dart';
import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/get_vehicles.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/vehicle_usecases.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(Env envConfig) async {
  // Dio
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: envConfig.baseUrl,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
      ),
    ),
  );

  // Data base
  locator.registerLazySingleton(() => AppDatabase());
  locator.registerLazySingleton(() => VehiclesDao(locator<AppDatabase>()));
  locator.registerLazySingleton(() => UsersDao(locator<AppDatabase>()));

  // Secure Storage
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  locator.registerLazySingleton<ISecureStorageService>(
    () => SecureStorage(locator<FlutterSecureStorage>()),
  );

  // Network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton(() => Connectivity());

  // Services
  locator.registerLazySingleton<AuthService>(() => AuthService(locator()));
  locator.registerLazySingleton<VehicleService>(
    () => VehicleService(locator()),
  );

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator<AuthService>(),
      locator<UsersDao>(),
      locator<NetworkInfo>(),
    ),
  );
  locator.registerLazySingleton<VehicleRepository>(
    () => VehicleRepositoryImpl(
      locator<VehicleService>(),
      locator<VehiclesDao>(),
    ),
  );

  // Use Cases
  locator.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
      login: LoginUseCase(locator()),
      getToken: GetTokenUseCase(locator()),
      saveUserSession: SaveUserUsecase(locator()),
      logout: LogoutUseCase(locator()),
    ),
  );

  locator.registerLazySingleton<VehicleUseCases>(
    () => VehicleUseCases(getVehicles: GetVehiclesUseCase(locator())),
  );
}
