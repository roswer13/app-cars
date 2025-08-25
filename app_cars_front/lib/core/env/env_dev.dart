import 'package:app_cars_front/core/core.dart';

class EnvDev implements Env {
  @override
  String get appName => "Cars [DEV]";

  @override
  String get baseUrl => 'http://192.168.1.14:8000/api';

  @override
  String get env => BaseConstants.dev;
}
