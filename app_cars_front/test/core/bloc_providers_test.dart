import 'package:app_cars_front/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:app_cars_front/features/features.dart';

class MockAuthUseCases extends Mock implements AuthUseCases {}

void main() {
  final getIt = GetIt.instance;
  late MockAuthUseCases mockAuthUseCases;

  setUp(() {
    getIt.reset();

    mockAuthUseCases = MockAuthUseCases();

    getIt.registerLazySingleton<AuthUseCases>(() => mockAuthUseCases);
  });

  tearDown(() {
    getIt.reset();
  });

  test('blocProviders contains AuthBloc provider', () {
    // Arrange
    // Act
    final authProvider = blocProviders().firstWhere(
      (provider) => provider is BlocProvider<AuthBloc>,
      orElse: () => throw Exception('AuthBloc provider not found'),
    );
    // Assert
    expect(authProvider, isA<BlocProvider<AuthBloc>>());
  });
}
