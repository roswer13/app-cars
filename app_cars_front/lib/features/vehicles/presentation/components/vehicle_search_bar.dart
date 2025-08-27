import 'package:app_cars_front/features/features.dart';
import 'package:flutter/material.dart';

class VehicleSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const VehicleSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        decoration: InputDecorations.decoration(
          labelText: 'Buscar vehículo',
          hintText: 'Buscar vehículo por placa...',
          prefixIcon: Icons.search,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
