import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<AuthBloc>(
    create: (context) =>
        AuthBloc(locator<AuthUseCases>())..add(AuthInitialEvent()),
  ),
];
