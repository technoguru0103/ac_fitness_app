import 'package:ac_fit/models/auth_state.dart';
import 'package:ac_fit/actions/auth_actions.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is LoginRequestAction || action is SignupRequestAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoginSuccessAction) {
    return state.copyWith(
      isAuthenticated: true,
      token: action.token,
      isLoading: false,
      error: null,
    );
  } else if (action is LoginFailureAction || action is SignupFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  } else if (action is LogoutAction) {
    return AuthState.initial();
  }
  return state;
}
