import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  static const String routeName = 'map';

  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map Page")),
      body: const Center(child: Text('Map content goes here')),
    );
  }
}
