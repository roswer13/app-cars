import 'dart:async';

import 'package:app_cars_front/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  StreamSubscription? _gpsServiceStatusStream;

  MapBloc()
    : super(const MapState(isGpsEnabled: false, isGpsPermissionGrated: false)) {
    on<GpsAndPermissionEvent>(_onGpsAndPermissionEvent);

    _init();
  }

  void _onGpsAndPermissionEvent(
    GpsAndPermissionEvent event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGrated: event.isGpsPermissionGrated,
      ),
    );
  }

  /// Initializes the GPS and permission status.
  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(
      GpsAndPermissionEvent(
        isGpsEnabled: gpsInitStatus[0],
        isGpsPermissionGrated: gpsInitStatus[1],
      ),
    );
  }

  /// Checks if the location permission is granted.
  Future<bool> _isPermissionGranted() async {
    return await Permission.location.isGranted;
  }

  /// Checks if the GPS is enabled.
  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    _gpsServiceStatusStream = Geolocator.getServiceStatusStream().listen((
      event,
    ) {
      final isEnable = (event.index == 1) ? true : false;
      add(
        GpsAndPermissionEvent(
          isGpsEnabled: isEnable,
          isGpsPermissionGrated: state.isGpsPermissionGrated,
        ),
      );
    });
    return isEnable;
  }

  /// Requests GPS access from the user.
  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGrated: true,
          ),
        );

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGrated: false,
          ),
        );
        openAppSettings();
        break;
    }
  }

  @override
  Future<void> close() {
    _gpsServiceStatusStream?.cancel();
    return super.close();
  }
}
