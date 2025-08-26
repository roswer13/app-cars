import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleUseCases vehicleUseCases;

  VehicleBloc(this.vehicleUseCases) : super(const VehicleState()) {
    on<VehicleLoadedEvent>(_onVehicleLoadedEvent);
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

    String? url = state.nextUrl;
    Resource<VehicleResponse> result = await vehicleUseCases.getVehicles.run(
      url,
    );

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
  }
}
