import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/auth/domain/domain.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitialEvent extends AuthEvent {
  const AuthInitialEvent();

  @override
  List<Object?> get props => [];
}

class AuthFormReset extends AuthEvent {
  const AuthFormReset();
}

class AuthSaveUserSession extends AuthEvent {
  final TokenResponse response;

  const AuthSaveUserSession({required this.response});

  @override
  List<Object?> get props => [response];
}

class AccountChanged extends AuthEvent {
  final BlocFormItem account;

  const AccountChanged({required this.account});

  @override
  List<Object?> get props => [account];
}

class PhoneChanged extends AuthEvent {
  final BlocFormItem phone;

  const PhoneChanged({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class AuthSubmitted extends AuthEvent {
  const AuthSubmitted();
}

class AuthLogout extends AuthEvent {
  const AuthLogout();
}
