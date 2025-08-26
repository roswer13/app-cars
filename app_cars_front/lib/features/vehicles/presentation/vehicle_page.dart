import 'package:app_cars_front/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_cars_front/features/features.dart';

class VehiclePage extends StatefulWidget {
  static const String routeName = 'vehicle';

  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  VehicleBloc? vehicleBloc;

  @override
  Widget build(BuildContext context) {
    vehicleBloc = BlocProvider.of<VehicleBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Vehicle Page")),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            if (state.response is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.response is Error) {
              final error = state.response as Error;
              return Center(child: Text('Error: ${error.message}'));
            } else if (state.response == null) {
              return Center(child: Text('No data available'));
            }

            final response = state.response as Success<VehicleResponse>;
            final items = response.data.results;

            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return VehicleItem(item: items[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 1, color: Colors.grey);
              },
            );
          },
        ),
      ),
    );
  }
}
