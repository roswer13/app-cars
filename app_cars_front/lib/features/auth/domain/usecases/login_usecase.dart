import 'package:app_cars_front/features/features.dart';

class LoginUseCase {
  AuthRepository repository;

  LoginUseCase(this.repository);

  run() async {
    return await repository.login();
  }
}
