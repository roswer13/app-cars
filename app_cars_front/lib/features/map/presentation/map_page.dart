import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_cars_front/core/core.dart';
import 'package:app_cars_front/features/features.dart';

class MapPage extends StatelessWidget {
  static const String routeName = 'map';

  final List<VehicleResult> vehicles;

  const MapPage({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map Page")),
      body: Center(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state.isAllGranted) {
              return MapContent(vehicles: vehicles);
            }

            return !state.isGpsEnabled
                ? const _EnableGpsMessage()
                : _AccessButton();
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el acceso al GPS'),
        ButtonBase(
          onPressed: () {
            final gps = BlocProvider.of<MapBloc>(context);
            gps.askGpsAccess();
          },
          text: 'Solicitar Acceso',
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Debe hablitar el GPS'));
  }
}
