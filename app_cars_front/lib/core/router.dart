import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cars_front/features/features.dart';

final appRouter = GoRouter(
  initialLocation: '/${AuthPage.routeName}',
  routes: [
    GoRoute(
      name: AuthPage.routeName,
      path: '/${AuthPage.routeName}',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      name: DashboardPage.routeName,
      path: '/${DashboardPage.routeName}',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      name: VehiclePage.routeName,
      path: '/${VehiclePage.routeName}',
      builder: (context, state) => const VehiclePage(),
    ),
    GoRoute(
      name: MapPage.routeName,
      path: '/${MapPage.routeName}',
      builder: (context, state) {
        final vehicles = state.extra as List<VehicleResult>;
        return MapPage(vehicles: vehicles);
      },
    ),
  ],
);
