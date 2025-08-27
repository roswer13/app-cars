import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/core/db/app_database.dart';
import 'package:app_cars_front/features/auth/data/datasource/local/models/user_dao.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/data/models/vehicle_dao.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/remote/vehicle_service.dart';
import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/vehicle_usecases.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockEnv extends Mock implements Env {}

void main() {
  final locator = GetIt.instance;

  setUp(() {
    // Limpiar cualquier registro anterior
    locator.reset();
  });

  test('configureDependencies registers all services and use cases', () async {
    final env = MockEnv();
    when(() => env.baseUrl).thenReturn('https://example.com');

    await configureDependencies(env);

    // Dio
    expect(locator<Dio>(), isA<Dio>());

    // Database
    expect(locator<AppDatabase>(), isA<AppDatabase>());
    expect(locator<VehiclesDao>(), isA<VehiclesDao>());
    expect(locator<UsersDao>(), isA<UsersDao>());

    // Secure Storage
    expect(locator<FlutterSecureStorage>(), isA<FlutterSecureStorage>());
    expect(locator<ISecureStorageService>(), isA<ISecureStorageService>());

    // Network
    expect(locator<NetworkInfo>(), isA<NetworkInfo>());
    expect(locator<Connectivity>(), isA<Connectivity>());

    // Services
    expect(locator<AuthService>(), isA<AuthService>());
    expect(locator<VehicleService>(), isA<VehicleService>());

    // Repositories
    expect(locator<AuthRepository>(), isA<AuthRepository>());
    expect(locator<VehicleRepository>(), isA<VehicleRepository>());

    // Use Cases
    expect(locator<AuthUseCases>(), isA<AuthUseCases>());
    expect(locator<VehicleUseCases>(), isA<VehicleUseCases>());
  });
}
