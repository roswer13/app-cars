import 'dart:io';

import 'package:app_cars_front/core/network/network_info_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test('returns false when connectivity result is none', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkInfoImpl.isConnected;

      expect(result, false);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });

    test(
      'returns true when lookup succeeds and connectivity is available',
      () async {
        when(
          () => mockConnectivity.checkConnectivity(),
        ).thenAnswer((_) async => [ConnectivityResult.wifi]);

        final networkInfo = NetworkInfoImpl(
          mockConnectivity,
          lookupFn: (_) async => [InternetAddress('8.8.8.8')],
        );

        final result = await networkInfo.isConnected;

        expect(result, true);
      },
    );

    test('returns false when lookup throws SocketException', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.mobile]);

      final networkInfo = NetworkInfoImpl(
        mockConnectivity,
        lookupFn: (_) => throw const SocketException('no internet'),
      );
      final result = await networkInfo.isConnected;

      expect(result, false);
    });

    test('returns false when lookup returns empty list', () async {
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.ethernet]);

      final networkInfo = NetworkInfoImpl(
        mockConnectivity,
        lookupFn: (_) async => [],
      );

      final result = await networkInfo.isConnected;

      expect(result, false);
    });
  });
}
