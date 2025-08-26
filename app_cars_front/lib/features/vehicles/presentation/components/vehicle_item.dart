import 'package:flutter/material.dart';

import 'package:app_cars_front/features/vehicles/domain/models/vehicle_response.dart';

class VehicleItem extends StatelessWidget {
  final VehicleResult item;

  const VehicleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _getStatusColor(item.statusColor),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'black':
      return Colors.black;
    case 'red':
      return Colors.red;
    default:
      return Colors.red;
  }
}
