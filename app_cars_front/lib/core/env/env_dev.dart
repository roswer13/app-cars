import 'package:app_cars_front/core/core.dart';

class EnvDev implements Env {
  @override
  String get appName => "Cars [DEV]";

  @override
  String get baseUrl => throw UnimplementedError();

  @override
  String get env => BaseConstants.dev;
}
