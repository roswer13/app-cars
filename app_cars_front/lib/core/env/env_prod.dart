import 'package:app_cars_front/core/core.dart';

class EnvProd implements Env {
  @override
  String get appName => "Cars";

  @override
  String get baseUrl => throw UnimplementedError();

  @override
  String get env => BaseConstants.prod;
}
