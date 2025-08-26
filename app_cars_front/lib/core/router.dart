import 'package:go_router/go_router.dart';

import 'package:app_cars_front/features/features.dart';

final appRouter = GoRouter(
  initialLocation: '/${LoginPage.routeName}',
  routes: [
    GoRoute(
      name: LoginPage.routeName,
      path: '/${LoginPage.routeName}',
      builder: (context, state) => const LoginPage(),
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
      builder: (context, state) => const MapPage(),
    ),
  ],
);
