import 'dart:io';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ac_fit/store/app_store.dart';
import '../actions/auth_actions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ac_fit/config.dart';

ThunkAction<AppState> login(
    String email, String password, Function onSuccess, Function onError) {
  return (Store<AppState> store) async {
    store.dispatch(LoginRequestAction());

    try {
      final response = await http.post(
        Uri.parse("$BACKEND_URL/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final token = responseData["token"];
        store.dispatch(LoginSuccessAction(token));
        onSuccess();
      } else {
        store.dispatch(LoginFailureAction(responseData['message']));
        onError(response.statusCode);
      }
    } catch (e) {
      store.dispatch(LoginFailureAction(e.toString()));
      onError(-1);
    }
  };
}

ThunkAction<AppState> signup(
    String email, String password, Function onSuccess) {
  return (Store<AppState> store) async {
    store.dispatch(SignupRequestAction());

    try {
      final response = await http.post(
        Uri.parse("$BACKEND_URL/auth/signup"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // final responseData = json.decode(response.body);
        store.dispatch(SignupSuccessAction(responseData['message']));
        onSuccess();
      } else {
        store.dispatch(SignupFailureAction(
            "Signup failed: ${responseData['message'] ?? 'Unknown error'}"));
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
