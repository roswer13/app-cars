import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = 'dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(child: Text('Dashboard Page')),
    );
  }
}
