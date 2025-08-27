import 'package:app_cars_front/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNetworkInfo implements NetworkInfo {
  bool _connected;
  MockNetworkInfo(this._connected);

  @override
  Future<bool> get isConnected async => _connected;
}

void main() {
  group('NetworkInfo', () {
    test('should return true when device is connected', () async {
      final networkInfo = MockNetworkInfo(true);

      final result = await networkInfo.isConnected;

      expect(result, isTrue);
    });

    test('should return false when device is not connected', () async {
      final networkInfo = MockNetworkInfo(false);

      final result = await networkInfo.isConnected;

      expect(result, isFalse);
    });
  });
}
