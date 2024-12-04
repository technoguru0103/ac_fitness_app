class LoginRequestAction {}

class LoginSuccessAction {
  final String token;

  LoginSuccessAction(this.token);
}

class LoginFailureAction {
  final String error;

  LoginFailureAction(this.error);
}

class LogoutAction {}

class SignupRequestAction {}

class SignupSuccessAction {}

class SignupFailureAction {
  final String error;

  SignupFailureAction(this.error);
}
