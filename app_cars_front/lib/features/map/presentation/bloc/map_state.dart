import 'package:equatable/equatable.dart';

class MapState extends Equatable {
  /// Indicates whether the device's GPS is enabled.
  final bool isGpsEnabled;

  /// Indicates whether the app has been granted GPS permissions.
  final bool isGpsPermissionGrated;

  /// Returns `true` if both GPS is enabled and permission is granted.
  bool get isAllGranted => isGpsEnabled && isGpsPermissionGrated;

  const MapState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGrated,
  });

  MapState copyWith({bool? isGpsEnabled, bool? isGpsPermissionGrated}) {
    return MapState(
      isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
      isGpsPermissionGrated:
          isGpsPermissionGrated ?? this.isGpsPermissionGrated,
    );
  }

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGrated];

  @override
  String toString() =>
      'MapState(isGpsEnabled: $isGpsEnabled, isGpsPermissionGrated: $isGpsPermissionGrated)';
}
