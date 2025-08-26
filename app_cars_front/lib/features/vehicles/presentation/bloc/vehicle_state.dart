import 'package:equatable/equatable.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';

class VehicleState extends Equatable {
  final List<VehicleResult>? vehicles;
  final Resource? response;
  final String? nextUrl;
  final bool hasReachedEnd;

  const VehicleState({
    this.vehicles,
    this.response,
    this.nextUrl,
    this.hasReachedEnd = false,
  });

  VehicleState copyWith({
    List<VehicleResult>? vehicles,
    Resource? response,
    String? nextUrl,
    bool? hasReachedEnd,
  }) {
    return VehicleState(
      vehicles: vehicles ?? this.vehicles,
      response: response ?? this.response,
      nextUrl: nextUrl ?? this.nextUrl,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [vehicles, response, nextUrl, hasReachedEnd];
}
