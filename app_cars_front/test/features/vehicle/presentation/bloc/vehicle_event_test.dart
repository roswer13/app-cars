import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/features/vehicles/presentation/bloc/vehicle_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VehicleEvent', () {
    test('props are empty by default', () {
      const event = VehicleRefreshEvent();
      expect(event.props, []);
      expect(event == const VehicleRefreshEvent(), true);
    });
  });

  group('VehicleLoadedEvent', () {
    test('supports value equality', () {
      const event1 = VehicleLoadedEvent();
      const event2 = VehicleLoadedEvent();
      expect(event1, event2);
    });

    test('props contain vehicles and nextPageUrl', () {
      final vehicles = <VehicleResult>[
        VehicleResult(
          id: 1,
          plate: 'AAA123',
          label: 'Car 1',
          statusColor: 'green',
          latitude: '10.0',
          longitude: '20.0',
        ),
      ];

      final event = VehicleLoadedEvent(
        vehicles: vehicles,
        nextPageUrl: 'page2',
      );

      expect(event.props, [vehicles, 'page2']);
      expect(event.vehicles, vehicles);
      expect(event.nextPageUrl, 'page2');
    });

    test('props handle null values', () {
      const event = VehicleLoadedEvent();
      expect(event.props, [null, null]);
    });
  });

  group('VehicleRefreshEvent', () {
    test('supports value equality', () {
      const event1 = VehicleRefreshEvent();
      const event2 = VehicleRefreshEvent();
      expect(event1, event2);
    });

    test('props are empty', () {
      const event = VehicleRefreshEvent();
      expect(event.props, []);
    });
  });

  group('VehicleDeleteAllEvent', () {
    test('supports value equality', () {
      const event1 = VehicleDeleteAllEvent();
      const event2 = VehicleDeleteAllEvent();
      expect(event1, event2);
    });

    test('props are empty', () {
      const event = VehicleDeleteAllEvent();
      expect(event.props, []);
    });
  });
}
