import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/get_vehicles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  late MockVehicleRepository mockRepository;
  late GetVehiclesUseCase useCase;

  setUp(() {
    mockRepository = MockVehicleRepository();
    useCase = GetVehiclesUseCase(mockRepository);
  });

  final vehicleResult = VehicleResult(
    id: 1,
    plate: 'ABC123',
    label: 'Car 1',
    statusColor: 'green',
    latitude: '12.34',
    longitude: '56.78',
  );

  test('calls getAll on repository and returns Success', () async {
    // Arrange
    when(
      () => mockRepository.getAll(true),
    ).thenAnswer((_) async => Success([vehicleResult]));

    // Act
    final result = await useCase.run(true);

    // Assert
    expect(result, isA<Success<List<VehicleResult>>>());
    expect((result as Success<List<VehicleResult>>).data.length, 1);
    verify(() => mockRepository.getAll(true)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('returns Error when repository fails', () async {
    // Arrange
    when(
      () => mockRepository.getAll(false),
    ).thenAnswer((_) async => Error('Failed to get vehicles'));

    // Act
    final result = await useCase.run(false);

    // Assert
    expect(result, isA<Error>());
    expect((result as Error).message, 'Failed to get vehicles');
    verify(() => mockRepository.getAll(false)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
