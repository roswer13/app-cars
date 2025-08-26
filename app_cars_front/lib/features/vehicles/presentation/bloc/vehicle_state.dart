import 'package:app_cars_front/core/core.dart';
import 'package:equatable/equatable.dart';

class VehicleState extends Equatable {
  final Resource? response;

  const VehicleState({this.response});

  VehicleState copyWith({Resource? response}) {
    return VehicleState(response: response ?? this.response);
  }

  @override
  List<Object?> get props => [response];
}
