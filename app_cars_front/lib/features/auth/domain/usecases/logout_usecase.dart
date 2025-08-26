import 'package:app_cars_front/features/features.dart';

class LogoutUseCase {
  AuthRepository repository;

  LogoutUseCase(this.repository);

  run() async {
    return await repository.logout();
  }
}
