import 'package:app_cars_front/core/core.dart' show ButtonBase;
import 'package:app_cars_front/features/features.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Header(),
              TextFormField(
                decoration: InputDecorations.decoration(
                  labelText: 'Usuario',
                  hintText: 'Ingrese su usuario',
                  prefixIcon: Icons.person,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecorations.decoration(
                  labelText: 'Telefono',
                  hintText: 'Ingrese su telefono',
                  prefixIcon: Icons.phone,
                ),
              ),
              const SizedBox(height: 16),
              ButtonBase(
                width: double.infinity,
                onPressed: () {},
                text: 'Ingresar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
