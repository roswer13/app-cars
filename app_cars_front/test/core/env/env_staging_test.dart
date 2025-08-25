import 'package:flutter_test/flutter_test.dart';
import 'package:app_cars_front/core/core.dart';

void main() {
  group('EnvStaging', () {
    final envStaging = EnvStaging();

    test('appName returns correct value', () {
      expect(envStaging.appName, equals('Cars [STAGING]'));
    });

    test('env returns BaseConstants.staging', () {
      expect(envStaging.env, equals(BaseConstants.staging));
    });

    test('baseUrl throws UnimplementedError', () {
      expect(() => envStaging.baseUrl, throwsA(isA<UnimplementedError>()));
    });
  });
}
