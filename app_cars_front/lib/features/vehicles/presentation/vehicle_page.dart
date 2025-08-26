import 'package:app_cars_front/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_cars_front/features/features.dart';
import 'package:go_router/go_router.dart';

class VehiclePage extends StatefulWidget {
  static const String routeName = 'vehicle';

  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final ScrollController _scrollController = ScrollController();
  VehicleBloc? vehicleBloc;

  @override
  void initState() {
    super.initState();
    vehicleBloc = BlocProvider.of<VehicleBloc>(context);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        vehicleBloc?.add(VehicleLoadedEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vehicle Page ")),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            if (state.response is Loading &&
                _scrollController.positions.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else if (state.response is Error) {
              final error = state.response as Error;
              return Center(child: Text('Error: ${error.message}'));
            } else if (state.response == null) {
              return Center(child: Text('No data available'));
            }

            final items = state.vehicles ?? [];

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (index < items.length) {
                        return VehicleItem(item: items[index]);
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1, color: Colors.grey);
                    },
                  ),
                ),
                ButtonBase(
                  onPressed: () {
                    context.push('/${MapPage.routeName}');
                  },
                  text: 'Ver a todos en el mapa',
                  width: double.infinity,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
