import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/core/db/app_database.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/data/models/vehicle_dao.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/remote/vehicle_service.dart';
import 'package:app_cars_front/features/vehicles/data/repository/vehicle_repository_impl.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockVehicleService extends Mock implements VehicleService {}

class MockVehiclesDao extends Mock implements VehiclesDao {}

class MockSecureStorageService extends Mock implements ISecureStorageService {}

void main() {
  late VehicleRepositoryImpl repository;
  late MockVehicleService mockService;
  late MockVehiclesDao mockDao;
  late MockSecureStorageService mockStorage;

  setUp(() {
    // Reset GetIt so we can re-register mocks
    GetIt.I.reset();

    mockService = MockVehicleService();
    mockDao = MockVehiclesDao();
    mockStorage = MockSecureStorageService();

    // override GetIt for tests
    GetIt.I.registerSingleton<ISecureStorageService>(mockStorage);

    repository = VehicleRepositoryImpl(mockService, mockDao);
  });

  final token = 'token_123';

  group('VehicleRepositoryImpl', () {
    test('get returns Error when no token is found', () async {
      when(() => mockStorage.read(any())).thenAnswer((_) async => null);

      final result = await repository.get(null);

      expect(result, isA<Error>());
      expect((result as Error).message, 'No token found');
    });

    test('get returns Success when service returns VehicleResponse', () async {
      when(() => mockStorage.read(any())).thenAnswer((_) async => token);

      final vehicleResponse = VehicleResponse(
        count: 1,
        next: null,
        previous: null,
        results: [
          VehicleResult(
            id: 1,
            plate: 'ABC123',
            label: 'Car 1',
            statusColor: 'green',
            latitude: '12.34',
            longitude: '56.78',
          ),
        ],
      );

      when(
        () => mockService.get(any(), token),
      ).thenAnswer((_) async => Success(vehicleResponse));

      final result = await repository.get(null);

      expect(result, isA<Success<VehicleResponse>>());
      final success = result as Success<VehicleResponse>;
      expect(success.data.results.length, 1);
      expect(success.data.results[0].plate, 'ABC123');
    });

    test(
      'getAll caches and returns vehicles from API if refresh or DB empty',
      () async {
        when(() => mockStorage.read(any())).thenAnswer((_) async => token);
        when(() => mockDao.getAllVehicles()).thenAnswer((_) async => []);

        final vehicleResponse = VehicleResponse(
          count: 1,
          next: null,
          previous: null,
          results: [
            VehicleResult(
              id: 1,
              plate: 'ABC123',
              label: 'Car 1',
              statusColor: 'green',
              latitude: '12.34',
              longitude: '56.78',
            ),
          ],
        );

        when(
          () => mockService.get(any(), token),
        ).thenAnswer((_) async => Success(vehicleResponse));
        when(() => mockDao.clearVehicles()).thenAnswer((_) async => {});
        when(() => mockDao.insertVehicles(any())).thenAnswer((_) async => {});
        when(() => mockDao.getAllVehicles()).thenAnswer(
          (_) async => [
            Vehicle(
              id: 1,
              plate: 'ABC123',
              label: 'Car 1',
              statusColor: 'green',
              latitude: '12.34',
              longitude: '56.78',
            ),
          ],
        );

        final result = await repository.getAll(true);

        expect(result, isA<Success<List<VehicleResult>>>());
        final success = result as Success<List<VehicleResult>>;
        expect(success.data.length, 1);
        expect(success.data[0].plate, 'ABC123');
      },
    );

    test('deleteAll clears vehicles from DB and returns Success', () async {
      when(() => mockDao.clearVehicles()).thenAnswer((_) async => {});

      final result = await repository.deleteAll();

      expect(result, isA<Success<void>>());
    });
  });
}
