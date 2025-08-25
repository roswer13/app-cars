import 'package:app_cars_front/features/features.dart';

class GetTokenUseCase {
  AuthRepository repository;

  GetTokenUseCase(this.repository);

  run(String account, String phone) async {
    return await repository.getToken(account, phone);
  }
}
