import 'package:equatable/equatable.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

// Event triggered when GPS and permission status changes.
class GpsAndPermissionEvent extends MapEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGrated;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled,
    required this.isGpsPermissionGrated,
  });

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGrated];
}
