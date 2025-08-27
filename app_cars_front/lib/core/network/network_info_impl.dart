import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:app_cars_front/core/core.dart';

typedef LookupFn = Future<List<InternetAddress>> Function(String host);

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final LookupFn lookupFn;

  NetworkInfoImpl(this.connectivity, {this.lookupFn = InternetAddress.lookup});

  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) return false;

    try {
      final lookup = await lookupFn('google.com');
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
