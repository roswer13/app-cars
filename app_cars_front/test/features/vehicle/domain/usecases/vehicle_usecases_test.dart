// ------------------ MOCKS ------------------
import 'package:app_cars_front/features/vehicles/domain/usecases/delete_all_vehicle.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/get_vehicles.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/vehicle_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetVehiclesUseCase extends Mock implements GetVehiclesUseCase {}

class MockDeleteAllVehiclesUseCase extends Mock
    implements DeleteAllVehiclesUseCase {}

void main() {
  late MockGetVehiclesUseCase mockGetVehicles;
  late MockDeleteAllVehiclesUseCase mockDeleteAllVehicles;
  late VehicleUseCases useCases;

  setUp(() {
    mockGetVehicles = MockGetVehiclesUseCase();
    mockDeleteAllVehicles = MockDeleteAllVehiclesUseCase();
    useCases = VehicleUseCases(
      getVehicles: mockGetVehicles,
      deleteAllVehicles: mockDeleteAllVehicles,
    );
  });

  test('VehicleUseCases contains the correct use case instances', () {
    expect(useCases.getVehicles, equals(mockGetVehicles));
    expect(useCases.deleteAllVehicles, equals(mockDeleteAllVehicles));
  });
}
