class AuthActionTypes {
  // ignore: constant_identifier_names
  static const String SIGNUP_REQUEST = "SIGNUP_REQUEST";
  // ignore: constant_identifier_names
  static const String SIGNUP_SUCCESS = "SIGNUP_SUCCESS";
  // ignore: constant_identifier_names
  static const String SIGNUP_FAILURE = "SIGNUP_FAILURE";
}

class LoginRequestAction {}

class LoginSuccessAction {
  final String token;

  LoginSuccessAction(this.token);
}

class LoginFailureAction {
  final String message;

  LoginFailureAction(this.message);
}

class LogoutAction {}

class SignupRequestAction {}

class SignupSuccessAction {
  final String message;
  SignupSuccessAction(this.message);
}

class SignupFailureAction {
  final String message;

  SignupFailureAction(this.message);
}
