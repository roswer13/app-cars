import 'package:app_cars_front/core/router.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock de Blocs
class MockAuthBloc extends Mock implements AuthBloc {}

class MockVehicleBloc extends Mock implements VehicleBloc {}

class MockMapBloc extends Mock implements MapBloc {}

void main() {
  late AuthBloc mockAuthBloc;
  late VehicleBloc mockVehicleBloc;
  late MapBloc mockMapBloc;

  List<BlocProvider> blocProviders = [];

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockVehicleBloc = MockVehicleBloc();
    mockMapBloc = MockMapBloc();

    when(() => mockAuthBloc.state).thenReturn(AuthState());
    when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockVehicleBloc.state).thenReturn(VehicleState());
    when(() => mockVehicleBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockMapBloc.state).thenReturn(
      const MapState(isGpsEnabled: false, isGpsPermissionGrated: false),
    );
    when(() => mockMapBloc.stream).thenAnswer((_) => const Stream.empty());

    blocProviders = [
      BlocProvider<AuthBloc>.value(value: mockAuthBloc),
      BlocProvider<VehicleBloc>.value(value: mockVehicleBloc),
      BlocProvider<MapBloc>.value(value: mockMapBloc),
    ];
  });

  group('AppRouter', () {
    testWidgets('initial route shows AuthPage', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(routerConfig: appRouter),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AuthPage), findsOneWidget);
    });

    testWidgets('navigate to DashboardPage', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(routerConfig: appRouter),
        ),
      );

      appRouter.go('/${DashboardPage.routeName}');
      await tester.pumpAndSettle();

      expect(find.byType(DashboardPage), findsOneWidget);
    });

    testWidgets('navigate to VehiclePage', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(routerConfig: appRouter),
        ),
      );

      // Navegar a VehiclePage
      appRouter.go('/${VehiclePage.routeName}');
      await tester.pumpAndSettle();

      expect(find.byType(VehiclePage), findsOneWidget);
    });

    testWidgets('navigate to MapPage with vehicles as extra', (
      WidgetTester tester,
    ) async {
      final vehicles = [
        VehicleResult(
          id: 1,
          plate: 'ABC123',
          label: 'Unidad 1',
          statusColor: 'green',
          latitude: '12.34',
          longitude: '56.78',
        ),
        VehicleResult(
          id: 2,
          plate: 'XYZ789',
          label: 'Unidad 2',
          statusColor: 'red',
          latitude: '56.78',
          longitude: '90.12',
        ),
      ];

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: blocProviders,
          child: MaterialApp.router(routerConfig: appRouter),
        ),
      );

      appRouter.go('/${MapPage.routeName}', extra: vehicles);
      await tester.pumpAndSettle();

      expect(find.byType(MapPage), findsOneWidget);

      // Comprobar que el widget recibió los vehículos
      final mapPage = tester.widget<MapPage>(find.byType(MapPage));
      expect(mapPage.vehicles, vehicles);
    });
  });
}
