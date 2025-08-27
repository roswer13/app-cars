import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:app_cars_front/core/core.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) return false;

    try {
      final lookup = await InternetAddress.lookup('google.com');
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
