import 'package:flutter_test/flutter_test.dart';
import 'package:app_cars_front/core/core.dart';

void main() {
  group('EnvUtil.getEnvConfig', () {
    test('returns EnvDev for BaseConstants.dev', () {
      final env = EnvUtil.getEnvConfig(BaseConstants.dev);
      expect(env, isA<EnvDev>());
    });

    test('returns EnvStaging for BaseConstants.staging', () {
      final env = EnvUtil.getEnvConfig(BaseConstants.staging);
      expect(env, isA<EnvStaging>());
    });

    test('returns EnvProd for BaseConstants.prod', () {
      final env = EnvUtil.getEnvConfig(BaseConstants.prod);
      expect(env, isA<EnvProd>());
    });

    test('throws UnimplementedError for unknown env', () {
      expect(
        () => EnvUtil.getEnvConfig('unknown_env'),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
