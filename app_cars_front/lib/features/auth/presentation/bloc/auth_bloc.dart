import 'package:app_cars_front/core/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_cars_front/features/features.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthUseCases authUseCases;

  AuthBloc(this.authUseCases) : super(AuthState()) {
    on<AuthInitialEvent>(_onAuthInitialEvent);
    on<AuthFormReset>(_onAuthFormReset);
    on<AuthSaveUserSession>(_onAuthSaveUserSession);
    on<AccountChanged>(_onAccountChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<AuthSubmitted>(_onAuthSubmitted);
    on<AuthLogout>(_onAuthLogout);
  }

  final formKey = GlobalKey<FormState>();

  void _onAuthInitialEvent(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(response: LoadingPage(), formKey: formKey));
    Resource<AuthResponse> response = await authUseCases.login.run();
    emit(state.copyWith(response: response, formKey: formKey));
  }

  void _onAuthFormReset(AuthFormReset event, Emitter<AuthState> emit) {
    state.formKey?.currentState?.reset();
  }

  void _onAuthSaveUserSession(
    AuthSaveUserSession event,
    Emitter<AuthState> emit,
  ) async {
    var response = state.response as Success<TokenResponse>;

    await authUseCases.saveUserSession.run(
      state.account.value,
      state.phone.value,
      response.data.token,
    );
  }

  void _onAccountChanged(AccountChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        account: BlocFormItem(
          value: event.account.value,
          error: event.account.value.isNotEmpty ? null : 'Ingrese su cuenta',
        ),
        formKey: formKey,
      ),
    );
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        phone: BlocFormItem(
          value: event.phone.value,
          error: event.phone.value.isNotEmpty ? null : 'Ingrese su teléfono',
        ),
        formKey: formKey,
      ),
    );
  }

  void _onAuthSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    print(
      'Submitting login with account: ${state.account.value} and phone: ${state.phone.value}',
    );

    Resource<TokenResponse> response = await authUseCases.getToken.run(
      state.account.value,
      state.phone.value,
    );

    emit(state.copyWith(response: response, formKey: formKey));
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    await authUseCases.logout.run();
    emit(state.copyWith(response: Success(null), formKey: formKey));
  }
}
