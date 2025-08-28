import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/core/core.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockVehicleBloc extends Mock implements VehicleBloc {}

class FakeVehicleState extends Fake implements VehicleState {}

class FakeVehicleEvent extends Fake implements VehicleEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeVehicleState());
    registerFallbackValue(FakeVehicleEvent());
  });

  group('VehiclePage', () {
    late VehicleBloc vehicleBloc;

    setUp(() {
      vehicleBloc = MockVehicleBloc();
    });

    Widget buildTestableWidget(VehicleState state) {
      when(() => vehicleBloc.state).thenReturn(state);
      return MaterialApp(
        home: BlocProvider<VehicleBloc>.value(
          value: vehicleBloc,
          child: const VehiclePage(),
        ),
      );
    }

    testWidgets('shows loading indicator when state is Loading', (
      tester,
    ) async {
      final state = VehicleState(response: Loading(), vehicles: []);
      whenListen(vehicleBloc, Stream.value(state), initialState: state);

      await tester.pumpWidget(buildTestableWidget(state));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when state is Error', (tester) async {
      final state = VehicleState(
        response: Error('Failed to load'),
        vehicles: [],
      );
      whenListen(vehicleBloc, Stream.value(state), initialState: state);

      await tester.pumpWidget(buildTestableWidget(state));
      expect(find.textContaining('Error: Failed to load'), findsOneWidget);
    });

    testWidgets('shows no data message when response is null', (tester) async {
      final state = VehicleState(response: null, vehicles: []);
      whenListen(vehicleBloc, Stream.value(state), initialState: state);

      await tester.pumpWidget(buildTestableWidget(state));
      expect(find.text('No data available'), findsOneWidget);
    });

    testWidgets('shows list of vehicles when data is loaded', (tester) async {
      final vehicles = [
        VehicleResult(
          id: 1,
          plate: 'ABC123',
          label: 'Car 1',
          statusColor: 'green',
          latitude: '12.34',
          longitude: '56.78',
        ),
        VehicleResult(
          id: 2,
          plate: 'XYZ789',
          label: 'Car 2',
          statusColor: 'red',
          latitude: '23.45',
          longitude: '67.89',
        ),
      ];
      final state = VehicleState(
        response: Success(vehicles),
        vehicles: vehicles,
      );
      whenListen(vehicleBloc, Stream.value(state), initialState: state);

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      expect(find.byType(VehicleItem), findsNWidgets(2));
      expect(find.byType(VehicleSearchBar), findsOneWidget);
      expect(find.byType(ButtonBase), findsOneWidget);
    });

    testWidgets('filters vehicles by search', (tester) async {
      final vehicles = [
        VehicleResult(
          id: 1,
          plate: 'ABC123',
          label: 'Car 1',
          statusColor: 'green',
          latitude: '12.34',
          longitude: '56.78',
        ),
        VehicleResult(
          id: 2,
          plate: 'XYZ789',
          label: 'Car 2',
          statusColor: 'red',
          latitude: '23.45',
          longitude: '67.89',
        ),
      ];
      final state = VehicleState(
        response: Success(vehicles),
        vehicles: vehicles,
      );
      whenListen(vehicleBloc, Stream.value(state), initialState: state);

      await tester.pumpWidget(buildTestableWidget(state));
      await tester.pumpAndSettle();

      // Enter search query
      await tester.enterText(find.byType(VehicleSearchBar), 'XYZ');
      await tester.pump(const Duration(milliseconds: 500)); // Debouncer

      expect(find.byType(VehicleItem), findsOneWidget);
      expect(find.textContaining('Car 2'), findsOneWidget);
    });
  });
}
