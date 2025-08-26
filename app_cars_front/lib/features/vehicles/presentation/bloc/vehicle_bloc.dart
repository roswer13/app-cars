import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:app_cars_front/features/vehicles/domain/usecases/vehicle_usecases.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleUseCases vehicleUseCases;

  VehicleBloc(this.vehicleUseCases) : super(const VehicleState()) {
    on<VehicleLoadedEvent>(_onVehicleLoadedEvent);
    on<VehicleRefreshEvent>(_onVehicleRefreshEvent);
  }

  void _onVehicleLoadedEvent(
    VehicleLoadedEvent event,
    Emitter<VehicleState> emit,
  ) async {
    if (state.hasReachedEnd || state.response is Loading) return;

    emit(
      state.copyWith(
        response: Loading(),
        vehicles: state.vehicles,
        nextUrl: state.nextUrl,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );

    // String? url = state.nextUrl;
    // Resource<VehicleResponse> result = await vehicleUseCases.getVehicles.run(url);

    Resource<List<VehicleResult>> result = await vehicleUseCases.getVehicles
        .run(false);

    /*
    if (result is Success<VehicleResponse>) {
      emit(
        state.copyWith(
          vehicles: [...state.vehicles ?? [], ...result.data.results],
          response: Success(result.data.results),
          nextUrl: result.data.next,
          hasReachedEnd: result.data.next == null,
        ),
      );
    }
    */
    if (result is Success<List<VehicleResult>>) {
      emit(
        state.copyWith(
          vehicles: [...state.vehicles ?? [], ...result.data],
          response: Success(result.data),
          hasReachedEnd: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          response: Error('Error'),
          vehicles: state.vehicles,
          nextUrl: state.nextUrl,
          hasReachedEnd: state.hasReachedEnd,
        ),
      );
    }
  }

  void _onVehicleRefreshEvent(
    VehicleRefreshEvent event,
    Emitter<VehicleState> emit,
  ) async {
    if (state.response is Loading) return;

    emit(
      state.copyWith(
        response: Loading(),
        vehicles: state.vehicles,
        nextUrl: state.nextUrl,
        hasReachedEnd: state.hasReachedEnd,
      ),
    );

    Resource<List<VehicleResult>> result = await vehicleUseCases.getVehicles
        .run(true);

    if (result is Success<List<VehicleResult>>) {
      emit(
        state.copyWith(
          vehicles: result.data,
          response: Success(result.data),
          hasReachedEnd: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          response: Error('Error'),
          vehicles: state.vehicles,
          nextUrl: state.nextUrl,
          hasReachedEnd: state.hasReachedEnd,
        ),
      );
    }
  }
}
