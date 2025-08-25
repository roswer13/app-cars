import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

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

            print('AuthState changed: $responseState');
            if (responseState is Success) {
              print('Login successful: ${responseState.data}');
              // If login is successful, save the user session
              authBloc?.add(
                AuthSaveUserSession(
                  response: responseState.data as TokenResponse,
                ),
              );
            }
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
              return Form(
                key: state.formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Header(),
                      TextFormField(
                        decoration: InputDecorations.decoration(
                          labelText: 'Nombre de cuenta',
                          hintText: 'Ingrese su nombre de cuenta',
                          prefixIcon: Icons.person,
                        ),
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          authBloc?.add(
                            AccountChanged(account: BlocFormItem(value: text)),
                          );
                        },
                        validator: (value) {
                          return state.account.error;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecorations.decoration(
                          labelText: 'Telefono',
                          hintText: 'Ingrese su telefono',
                          prefixIcon: Icons.phone,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (text) {
                          authBloc?.add(
                            PhoneChanged(phone: BlocFormItem(value: text)),
                          );
                        },
                        validator: (value) {
                          return state.phone.error;
                        },
                      ),
                      const SizedBox(height: 16),
                      ButtonBase(
                        isDisabled: state.response is Loading,
                        isLoading: state.response is Loading,
                        width: double.infinity,
                        onPressed: () {
                          if (state.formKey!.currentState!.validate()) {
                            // If the form is valid, proceed with login
                            authBloc?.add(AuthSubmitted());
                          }
                        },
                        text: 'Ingresar',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
