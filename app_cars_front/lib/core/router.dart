import 'package:app_cars_front/features/auth/presentation/login_page.dart';
import 'package:app_cars_front/features/dashboard/presentation/dashboard_page.dart';
import 'package:app_cars_front/features/vehicles/presentation/vehicle_page.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
