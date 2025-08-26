import 'package:app_cars_front/features/features.dart';
import 'package:equatable/equatable.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object?> get props => [];
}

class VehicleLoadedEvent extends VehicleEvent {
  final List<Vehicle>? vehicles;
  final String? nextPageUrl;

  const VehicleLoadedEvent({this.vehicles, this.nextPageUrl});

  @override
  List<Object?> get props => [vehicles, nextPageUrl];
}
