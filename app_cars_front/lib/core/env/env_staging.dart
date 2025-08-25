import 'package:app_cars_front/core/core.dart';

class EnvStaging implements Env {
  @override
  String get appName => "Cars [STAGING]";

  @override
  String get baseUrl => throw UnimplementedError();

  @override
  String get env => BaseConstants.staging;
}
