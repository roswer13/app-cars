import 'package:app_cars_front/core/util/util.dart';
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
  }

  void _onAuthInitialEvent(AuthInitialEvent event, Emitter<AuthState> emit) {}

  void _onAuthFormReset(AuthFormReset event, Emitter<AuthState> emit) {}

  void _onAuthSaveUserSession(
    AuthSaveUserSession event,
    Emitter<AuthState> emit,
  ) {}

  void _onAccountChanged(AccountChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        account: BlocFormItem(
          value: event.account.value,
          error: event.account.value.isNotEmpty ? null : 'Ingrese su cuenta',
        ),
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
      ),
    );
  }

  void _onAuthSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(response: Loading()));

    print(
      'Submitting login with account: ${state.account.value} and phone: ${state.phone.value}',
    );

    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(response: Error('Error al iniciar sesión')));
  }
}
