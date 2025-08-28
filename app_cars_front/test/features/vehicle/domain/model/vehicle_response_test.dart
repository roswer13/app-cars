import 'dart:convert';

import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VehicleResponse JSON serialization', () {
    final vehicleResultJson = {
      "id": 1,
      "plate": "ABC123",
      "label": "Car 1",
      "status_color": "green",
      "latitude": "12.34",
      "longitude": "56.78",
    };

    final vehicleResponseJson = {
      "count": 1,
      "next": null,
      "previous": null,
      "results": [vehicleResultJson],
    };

    test('fromJson creates correct VehicleResponse object', () {
      final jsonString = jsonEncode(vehicleResponseJson);
      final response = vehicleResponseFromJson(jsonString);

      expect(response.count, 1);
      expect(response.next, isNull);
      expect(response.previous, isNull);
      expect(response.results, isA<List<VehicleResult>>());
      expect(response.results.first.id, 1);
      expect(response.results.first.plate, 'ABC123');
      expect(response.results.first.label, 'Car 1');
      expect(response.results.first.statusColor, 'green');
      expect(response.results.first.latitude, '12.34');
      expect(response.results.first.longitude, '56.78');
    });

    test('toJson converts VehicleResponse object to correct JSON', () {
      final vehicleResult = VehicleResult(
        id: 1,
        plate: 'ABC123',
        label: 'Car 1',
        statusColor: 'green',
        latitude: '12.34',
        longitude: '56.78',
      );

      final response = VehicleResponse(
        count: 1,
        next: null,
        previous: null,
        results: [vehicleResult],
      );

      final jsonMap = vehicleResponseToJson(response);
      final decodedMap = jsonDecode(jsonMap);

      expect(decodedMap['count'], 1);
      expect(decodedMap['next'], isNull);
      expect(decodedMap['previous'], isNull);
      expect(decodedMap['results'], isA<List<dynamic>>());
      expect(decodedMap['results'][0]['id'], 1);
      expect(decodedMap['results'][0]['plate'], 'ABC123');
      expect(decodedMap['results'][0]['label'], 'Car 1');
      expect(decodedMap['results'][0]['status_color'], 'green');
      expect(decodedMap['results'][0]['latitude'], '12.34');
      expect(decodedMap['results'][0]['longitude'], '56.78');
    });

    test('serialization -> deserialization returns equal object', () {
      final vehicleResult = VehicleResult(
        id: 1,
        plate: 'ABC123',
        label: 'Car 1',
        statusColor: 'green',
        latitude: '12.34',
        longitude: '56.78',
      );

      final originalResponse = VehicleResponse(
        count: 1,
        next: null,
        previous: null,
        results: [vehicleResult],
      );

      final jsonString = vehicleResponseToJson(originalResponse);
      final deserializedResponse = vehicleResponseFromJson(jsonString);

      expect(deserializedResponse.count, originalResponse.count);
      expect(deserializedResponse.next, originalResponse.next);
      expect(deserializedResponse.previous, originalResponse.previous);
      expect(
        deserializedResponse.results.length,
        originalResponse.results.length,
      );
      expect(
        deserializedResponse.results.first.id,
        originalResponse.results.first.id,
      );
      expect(
        deserializedResponse.results.first.plate,
        originalResponse.results.first.plate,
      );
    });
  });
}
