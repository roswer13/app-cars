import 'package:app_cars_front/features/features.dart';

class AuthUseCases {
  LoginUseCase login;
  GetTokenUseCase getToken;
  SaveUserUsecase saveUserSession;
  LogoutUseCase logout;

  AuthUseCases({
    required this.login,
    required this.getToken,
    required this.saveUserSession,
    required this.logout,
  });
}
