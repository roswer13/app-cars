import 'package:equatable/equatable.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();
}

class VehicleLoadedEvent extends VehicleEvent {
  final List<VehicleResult>? vehicles;
  final String? nextPageUrl;

  const VehicleLoadedEvent({this.vehicles, this.nextPageUrl});

  @override
  List<Object?> get props => [vehicles, nextPageUrl];
}

class VehicleRefreshEvent extends VehicleEvent {
  const VehicleRefreshEvent();

  @override
  List<Object?> get props => [];
}

class VehicleDeleteAllEvent extends VehicleEvent {
  const VehicleDeleteAllEvent();

  @override
  List<Object?> get props => [];
}
