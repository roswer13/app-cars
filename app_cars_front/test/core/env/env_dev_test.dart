import 'package:flutter_test/flutter_test.dart';
import 'package:app_cars_front/core/core.dart';

void main() {
  group('EnvDev', () {
    final envDev = EnvDev();

    test('appName returns correct value', () {
      expect(envDev.appName, equals('Cars [DEV]'));
    });

    test('env returns BaseConstants.dev', () {
      expect(envDev.env, equals(BaseConstants.dev));
    });

    test('baseUrl throws UnimplementedError', () {
      expect(() => envDev.baseUrl, throwsA(isA<UnimplementedError>()));
    });
  });
}
