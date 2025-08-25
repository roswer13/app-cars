import 'package:flutter_test/flutter_test.dart';
import 'package:app_cars_front/core/core.dart';

void main() {
  group('EnvProd', () {
    final envProd = EnvProd();

    test('appName returns correct value', () {
      expect(envProd.appName, equals('Cars'));
    });

    test('env returns BaseConstants.prod', () {
      expect(envProd.env, equals(BaseConstants.prod));
    });

    test('baseUrl throws UnimplementedError', () {
      expect(() => envProd.baseUrl, throwsA(isA<UnimplementedError>()));
    });
  });
}
