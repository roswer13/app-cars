import 'package:app_cars_front/core/core.dart';

/// Utility class for retrieving environment-specific configuration objects.
class EnvUtil {
  /// Retrieves the environment-specific configuration object based
  /// on the provided [env] string.
  static Env getEnvConfig(String env) {
    switch (env) {
      /// Development environment configuration.
      case BaseConstants.dev:
        return EnvDev();

      /// Staging environment configuration.
      case BaseConstants.staging:
        return EnvStaging();

      /// Production environment configuration.
      case BaseConstants.prod:
        return EnvProd();

      /// Default environment configuration.
      default:
        throw UnimplementedError('Env $env is not implemented');
    }
  }
}
