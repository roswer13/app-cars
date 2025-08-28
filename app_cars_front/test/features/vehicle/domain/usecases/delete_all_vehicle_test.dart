import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/repository/vehicle_repository.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/delete_all_vehicle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

void main() {
  late MockVehicleRepository mockRepository;
  late DeleteAllVehiclesUseCase useCase;

  setUp(() {
    mockRepository = MockVehicleRepository();
    useCase = DeleteAllVehiclesUseCase(mockRepository);
  });

  test('calls deleteAll on repository and returns Success', () async {
    // Arrange
    when(
      () => mockRepository.deleteAll(),
    ).thenAnswer((_) async => Success(null));

    // Act
    final result = await useCase.run();

    // Assert
    expect(result, isA<Success<void>>());
    verify(() => mockRepository.deleteAll()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('returns Error when repository fails', () async {
    // Arrange
    when(
      () => mockRepository.deleteAll(),
    ).thenAnswer((_) async => Error('Failed to delete'));

    // Act
    final result = await useCase.run();

    // Assert
    expect(result, isA<Error>());
    expect((result as Error).message, 'Failed to delete');
    verify(() => mockRepository.deleteAll()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
