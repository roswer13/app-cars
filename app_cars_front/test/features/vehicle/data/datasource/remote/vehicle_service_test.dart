import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/data/datasource/remote/vehicle_service.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDio mockDio;
  late VehicleService service;

  setUp(() {
    mockDio = MockDio();
    service = VehicleService(mockDio);
  });

  final vehicleResponseJson = {
    "count": 1,
    "next": null,
    "previous": null,
    "results": [
      {
        "id": 1,
        "plate": "ABC123",
        "label": "Car 1",
        "status_color": "green",
        "latitude": "12.34",
        "longitude": "56.78",
      },
    ],
  };

  test('returns Success<VehicleResponse> when Dio returns 200', () async {
    final response = Response(
      requestOptions: RequestOptions(path: '/vehicule/'),
      data: vehicleResponseJson,
      statusCode: 200,
    );

    when(
      () => mockDio.get(any(), options: any(named: 'options')),
    ).thenAnswer((_) async => response);

    final result = await service.get(null, 'dummyToken');

    expect(result, isA<Success<VehicleResponse>>());
    final data = (result as Success<VehicleResponse>).data;
    expect(data.results.first.id, 1);
    expect(data.results.first.plate, 'ABC123');
  });

  test('returns Error when Dio returns non-200 status code', () async {
    final response = Response(
      requestOptions: RequestOptions(path: '/vehicule/'),
      data: 'Unauthorized',
      statusCode: 401,
    );

    when(
      () => mockDio.get(any(), options: any(named: 'options')),
    ).thenAnswer((_) async => response);

    final result = await service.get(null, 'dummyToken');

    expect(result, isA<Error>());
    expect((result as Error).message, 'Unauthorized');
  });

  test('returns Error when Dio throws an exception', () async {
    when(
      () => mockDio.get(any(), options: any(named: 'options')),
    ).thenThrow(Exception('Network failure'));

    final result = await service.get(null, 'dummyToken');

    expect(result, isA<Error>());
    expect(
      (result as Error).message,
      contains('An error occurred during get:'),
    );
  });
}
