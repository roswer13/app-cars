import 'package:app_cars_front/core/core.dart' show ButtonBase;
import 'package:app_cars_front/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            final responseState = state.response;

            if (responseState is Error) {
              // Show an error message if login fails
              Fluttertoast.showToast(
                msg: 'Error en inicio de sesión',
                toastLength: Toast.LENGTH_LONG,
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Center(
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
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecorations.decoration(
                        labelText: 'Telefono',
                        hintText: 'Ingrese su telefono',
                        prefixIcon: Icons.phone,
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 16),
                    ButtonBase(
                      width: double.infinity,
                      onPressed: () {},
                      text: 'Ingresar',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
