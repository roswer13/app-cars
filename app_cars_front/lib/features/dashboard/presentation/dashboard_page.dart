import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = 'dashboard';

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);

    final List<DashboardItem> items = [
      DashboardItem(id: 1, title: "Supervisor", icon: Icons.supervisor_account),
      DashboardItem(id: 2, title: "Notificaciones", icon: Icons.notifications),
      DashboardItem(id: 3, title: "Lugares", icon: Icons.location_on),
      DashboardItem(id: 4, title: "Cerrar sesión", icon: Icons.exit_to_app),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Supervisor de Flota - Livetrack")),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            final responseState = state.response;
            print('Response State: $responseState');
            if (responseState is Success) {
              context.go('/${LoginPage.routeName}');
            }
          },
          child: Center(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2, // 2 columnas
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: items.map((item) {
                return GestureDetector(
                  onTap: () {
                    switch (item.id) {
                      case 1:
                        break;
                      case 2:
                        break;
                      case 3:
                        break;
                      case 4:
                        authBloc?.add(AuthLogout());
                        break;
                      default:
                        break;
                    }
                  },
                  child: DashboardCard(item: item),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
