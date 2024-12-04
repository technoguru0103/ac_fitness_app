import 'package:ac_fit/models/data_state.dart';
import 'package:ac_fit/reducers/data_reducer.dart';
import 'package:redux/redux.dart';
import 'package:ac_fit/models/auth_state.dart';
import 'package:ac_fit/reducers/auth_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AppState {
  final AuthState authState;
  final DataState dataState;

  AppState({required this.authState, required this.dataState});

  factory AppState.initial() {
    return AppState(
        authState: AuthState.initial(), dataState: DataState.initial());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      authState: authReducer(state.authState, action),
      dataState: dataReducer(state.dataState, action));
}

final Store<AppState> store = Store<AppState>(appReducer,
    initialState: AppState.initial(), middleware: [thunkMiddleware]);
