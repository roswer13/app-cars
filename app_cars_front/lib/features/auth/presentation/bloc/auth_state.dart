import 'package:equatable/equatable.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:flutter/material.dart';

class AuthState extends Equatable {
  final BlocFormItem account;
  final BlocFormItem phone;

  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const AuthState({
    this.account = const BlocFormItem(error: 'Ingrese el nombre de cuenta'),
    this.phone = const BlocFormItem(error: 'Ingrese su número de telefoníco'),
    this.response,
    this.formKey,
  });

  AuthState copyWith({
    BlocFormItem? account,
    BlocFormItem? phone,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return AuthState(
      account: account ?? this.account,
      phone: phone ?? this.phone,
      response: response ?? this.response,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [account, phone, response, formKey];
}
