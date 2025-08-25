import 'package:equatable/equatable.dart';

import 'package:app_cars_front/core/core.dart';

class AuthState extends Equatable {
  final BlocFormItem account;
  final BlocFormItem phone;

  final Resource? response;

  const AuthState({
    this.account = const BlocFormItem(error: 'Ingrese su cuenta'),
    this.phone = const BlocFormItem(error: 'Ingrese su teléfono'),
    this.response,
  });

  AuthState copyWith({
    BlocFormItem? account,
    BlocFormItem? phone,
    Resource? response,
  }) {
    return AuthState(
      account: account ?? this.account,
      phone: phone ?? this.phone,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [account, phone, response];
}
