import 'package:app_cars_front/features/features.dart';

class SaveUserUsecase {
  AuthRepository repository;

  SaveUserUsecase(this.repository);

  run(String account, String phone, String token) async {
    return await repository.saveUserSession(account, phone, token);
  }
}
