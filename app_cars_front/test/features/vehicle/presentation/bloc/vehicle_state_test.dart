import 'package:flutter_test/flutter_test.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/features/vehicles/presentation/bloc/vehicle_state.dart';

void main() {
  group('VehicleState', () {
    test('supports value comparison', () {
      expect(
        const VehicleState(hasReachedEnd: false),
        const VehicleState(hasReachedEnd: false),
      );
    });

    test('has correct default values', () {
      const state = VehicleState();
      expect(state.vehicles, isNull);
      expect(state.response, isNull);
      expect(state.nextUrl, isNull);
      expect(state.hasReachedEnd, false);
    });

    test('copyWith returns a new instance with updated values', () {
      const initialState = VehicleState(
        vehicles: null,
        response: null,
        nextUrl: null,
        hasReachedEnd: false,
      );

      final vehicles = <VehicleResult>[
        VehicleResult(
          id: 1,
          plate: 'AAA123',
          label: 'Test',
          statusColor: 'green',
          latitude: '10.0',
          longitude: '20.0',
        ),
      ];

      final updated = initialState.copyWith(
        vehicles: vehicles,
        nextUrl: 'nextPage',
        hasReachedEnd: true,
      );

      expect(updated.vehicles, vehicles);
      expect(updated.nextUrl, 'nextPage');
      expect(updated.hasReachedEnd, true);
      expect(updated.response, null);
    });

    test('copyWith retains old values if not provided', () {
      final state1 = VehicleState(
        vehicles: const [],
        response: Success(null),
        nextUrl: 'page1',
        hasReachedEnd: false,
      );

      final state2 = state1.copyWith();

      expect(state2.vehicles, state1.vehicles);
      expect(state2.response, state1.response);
      expect(state2.nextUrl, state1.nextUrl);
      expect(state2.hasReachedEnd, state1.hasReachedEnd);
    });

    test('props contains all fields', () {
      final vehicles = <VehicleResult>[
        VehicleResult(
          id: 1,
          plate: 'AAA123',
          label: 'Test',
          statusColor: 'green',
          latitude: '10.0',
          longitude: '20.0',
        ),
      ];

      final response = Success(vehicles);

      final state = VehicleState(
        vehicles: vehicles,
        response: response,
        nextUrl: 'nextPage',
        hasReachedEnd: true,
      );

      expect(state.props, [vehicles, response, 'nextPage', true]);
    });
  });
}
