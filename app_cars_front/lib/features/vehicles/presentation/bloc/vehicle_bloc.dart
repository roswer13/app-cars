import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleUseCases vehicleUseCases;

  VehicleBloc(this.vehicleUseCases) : super(const VehicleState()) {
    on<VehicleInitialEvent>(_onVehicleInitialEvent);
    on<VehicleLoadedEvent>(_onVehicleLoadedEvent);
  }

  void _onVehicleInitialEvent(
    VehicleInitialEvent event,
    Emitter<VehicleState> emit,
  ) {}

  void _onVehicleLoadedEvent(
    VehicleLoadedEvent event,
    Emitter<VehicleState> emit,
  ) async {
    emit(state.copyWith(response: Loading()));

    Resource<VehicleResponse> result = await vehicleUseCases.getVehicles.run();

    emit(state.copyWith(response: result));
  }
}
