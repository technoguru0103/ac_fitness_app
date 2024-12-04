import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ac_fit/store/app_store.dart';
import '../actions/auth_actions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ac_fit/config.dart';

ThunkAction<AppState> login(String email, String password) {
  return (Store<AppState> store) async {
    store.dispatch(LoginRequestAction());

    try {
      final response = await http.post(
        Uri.parse("$BACKEND_URL/auth/login"),
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData["token"];
        store.dispatch(LoginSuccessAction(token));
      } else {
        store.dispatch(LoginFailureAction("Invalid credentials"));
      }
    } catch (e) {
      store.dispatch(LoginFailureAction(e.toString()));
    }
  };
}

ThunkAction<AppState> signup(String email, String password) {
  return (Store<AppState> store) async {
    store.dispatch(SignupRequestAction());

    try {
      final response = await http.post(
        Uri.parse("$BACKEND_URL/auth/signup"),
        body: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        // final responseData = json.decode(response.body);
        store.dispatch(SignupSuccessAction());
      } else {
        store.dispatch(SignupFailureAction("Invalid"));
      }
    } catch (e) {
      store.dispatch(SignupFailureAction(e.toString()));
    }
  };
}

ThunkAction<AppState> logout() {
  return (Store<AppState> store) async {
    store.dispatch(LogoutAction());
  };
}
