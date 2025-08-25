import 'package:app_cars_front/features/features.dart';

class AuthUseCases {
  LoginUseCase login;
  GetTokenUseCase getToken;
  SaveUserUsecase saveUserSession;

  AuthUseCases({
    required this.login,
    required this.getToken,
    required this.saveUserSession,
  });
}
