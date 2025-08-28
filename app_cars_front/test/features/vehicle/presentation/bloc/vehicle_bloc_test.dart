// Mocks
import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/delete_all_vehicle.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/get_vehicles.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/vehicle_usecases.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockGetVehiclesUseCase extends Mock implements GetVehiclesUseCase {}

class MockDeleteAllVehiclesUseCase extends Mock
    implements DeleteAllVehiclesUseCase {}

void main() {
  late MockGetVehiclesUseCase mockGetVehicles;
  late MockDeleteAllVehiclesUseCase mockDeleteAllVehicles;
  late VehicleUseCases vehicleUseCases;

  final vehicle1 = VehicleResult(
    id: 1,
    plate: 'ABC123',
    label: 'Car 1',
    statusColor: 'green',
    latitude: '12.34',
    longitude: '56.78',
  );

  final vehicle2 = VehicleResult(
    id: 2,
    plate: 'XYZ789',
    label: 'Car 2',
    statusColor: 'red',
    latitude: '90.12',
    longitude: '45.67',
  );

  setUp(() {
    mockGetVehicles = MockGetVehiclesUseCase();
    mockDeleteAllVehicles = MockDeleteAllVehiclesUseCase();

    vehicleUseCases = VehicleUseCases(
      getVehicles: mockGetVehicles,
      deleteAllVehicles: mockDeleteAllVehicles,
    );
  });

  group('VehicleBloc', () {
    blocTest<VehicleBloc, VehicleState>(
      'emits [Loading, Success] when VehicleLoadedEvent succeeds',
      build: () {
        when(
          () => mockGetVehicles.run(false),
        ).thenAnswer((_) async => Success([vehicle1, vehicle2]));
        return VehicleBloc(vehicleUseCases);
      },
      act: (bloc) => bloc.add(VehicleLoadedEvent()),
      expect: () => [
        isA<VehicleState>().having(
          (s) => s.response,
          'response',
          isA<Loading>(),
        ),
        isA<VehicleState>()
            .having((s) => s.response, 'response', isA<Success>())
            .having((s) => (s.response as Success).data, 'vehicles', [
              vehicle1,
              vehicle2,
            ]),
      ],
      verify: (_) {
        verify(() => mockGetVehicles.run(false)).called(1);
      },
    );

    blocTest<VehicleBloc, VehicleState>(
      'emits [Loading, Error] when VehicleLoadedEvent fails',
      build: () {
        when(
          () => mockGetVehicles.run(false),
        ).thenAnswer((_) async => Error('Network error'));
        return VehicleBloc(vehicleUseCases);
      },
      act: (bloc) => bloc.add(VehicleLoadedEvent()),
      expect: () => [
        isA<VehicleState>().having(
          (s) => s.response,
          'response',
          isA<Loading>(),
        ),
        isA<VehicleState>().having((s) => s.response, 'response', isA<Error>()),
      ],
    );

    blocTest<VehicleBloc, VehicleState>(
      'emits [Loading, Success] when VehicleRefreshEvent succeeds',
      build: () {
        when(
          () => mockGetVehicles.run(true),
        ).thenAnswer((_) async => Success([vehicle1]));
        return VehicleBloc(vehicleUseCases);
      },
      act: (bloc) => bloc.add(VehicleRefreshEvent()),
      expect: () => [
        isA<VehicleState>().having(
          (s) => s.response,
          'response',
          isA<Loading>(),
        ),
        isA<VehicleState>()
            .having((s) => s.response, 'response', isA<Success>())
            .having((s) => (s.response as Success).data, 'vehicles', [
              vehicle1,
            ]),
      ],
      verify: (_) {
        verify(() => mockGetVehicles.run(true)).called(1);
      },
    );

    blocTest<VehicleBloc, VehicleState>(
      'emits [Loading, Error] when VehicleRefreshEvent fails',
      build: () {
        when(
          () => mockGetVehicles.run(true),
        ).thenAnswer((_) async => Error('Network error'));
        return VehicleBloc(vehicleUseCases);
      },
      act: (bloc) => bloc.add(VehicleRefreshEvent()),
      expect: () => [
        isA<VehicleState>().having(
          (s) => s.response,
          'response',
          isA<Loading>(),
        ),
        isA<VehicleState>().having((s) => s.response, 'response', isA<Error>()),
      ],
    );

    blocTest<VehicleBloc, VehicleState>(
      'emits [Loading, Success(null)] when VehicleDeleteAllEvent is triggered',
      build: () {
        when(() => mockDeleteAllVehicles.run()).thenAnswer((_) async => {});
        return VehicleBloc(vehicleUseCases);
      },
      act: (bloc) => bloc.add(VehicleDeleteAllEvent()),
      expect: () => [
        isA<VehicleState>().having(
          (s) => s.response,
          'response',
          isA<Loading>(),
        ),
        isA<VehicleState>().having(
          (s) => s.response,
          'response',
          isA<Success>(),
        ),
      ],
      verify: (_) {
        verify(() => mockDeleteAllVehicles.run()).called(1);
      },
    );
  });
}
