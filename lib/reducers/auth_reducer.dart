import 'package:ac_fit/models/auth_state.dart';
import 'package:ac_fit/actions/auth_actions.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is LoginRequestAction || action is SignupRequestAction) {
    return state.copyWith(isLoading: true, message: null);
  } else if (action is LoginSuccessAction) {
    return state.copyWith(
      isAuthenticated: true,
      token: action.token,
      isLoading: false,
      message: null,
    );
  } else if (action is LoginFailureAction || action is SignupFailureAction) {
    return state.copyWith(isLoading: false, message: action.message);
  } else if (action is LogoutAction) {
    return AuthState.initial();
  } else if (action is SignupSuccessAction) {
    return state.copyWith(isLoading: false, message: action.message);
  }
  return state;
}
