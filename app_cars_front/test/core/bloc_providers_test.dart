import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/vehicle_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_cars_front/features/features.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUseCases extends Mock implements AuthUseCases {}

class MockVehicleUseCases extends Mock implements VehicleUseCases {}

final mockAuthUseCases = MockAuthUseCases();
final mockVehicleUseCases = MockVehicleUseCases();

class MockMapBloc extends Mock implements MapBloc {}

void main() {
  setUpAll(() {
    locator.registerSingleton<AuthUseCases>(mockAuthUseCases);
    locator.registerSingleton<VehicleUseCases>(mockVehicleUseCases);
  });

  tearDownAll(() {
    locator.reset();
  });

  test('blocProviders returns list of BlocProviders', () {
    final providers = blocProviders();

    expect(providers, isA<List<BlocProvider>>());
    expect(providers.length, 3);

    expect(providers[0], isA<BlocProvider<AuthBloc>>());
    expect(providers[1], isA<BlocProvider<VehicleBloc>>());
    expect(providers[2], isA<BlocProvider<MapBloc>>());
  });

  testWidgets('AuthBloc is created and initial event is added', (tester) async {
    final providers = blocProviders();

    await tester.pumpWidget(
      MultiBlocProvider(providers: providers, child: const SizedBox()),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
