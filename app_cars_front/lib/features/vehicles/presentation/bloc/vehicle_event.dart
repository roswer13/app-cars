import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object?> get props => [];
}

class VehicleInitialEvent extends VehicleEvent {
  const VehicleInitialEvent();

  @override
  List<Object?> get props => [];
}

class VehicleLoadedEvent extends VehicleEvent {
  const VehicleLoadedEvent();

  @override
  List<Object?> get props => [];
}
