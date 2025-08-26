import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

/// Returns a list of [BlocProvider]s used throughout the application.
List<BlocProvider> blocProviders() => [
  // AuthBloc provider
  BlocProvider<AuthBloc>(
    create: (context) =>
        AuthBloc(locator<AuthUseCases>())..add(AuthInitialEvent()),
  ),
];
