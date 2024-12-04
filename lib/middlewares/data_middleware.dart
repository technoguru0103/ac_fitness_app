import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ac_fit/store/app_store.dart';
import 'package:ac_fit/actions/data_actions.dart';

ThunkAction<AppState> fetchData() {
  return (Store<AppState> store) async {
    store.dispatch(FetchDataAction());

    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        store.dispatch(FetchDataSuccessAction(data));
      } else {
        store.dispatch(FetchDataFailureAction("Failed to fetch data"));
      }
    } catch (e) {
      store.dispatch(FetchDataFailureAction(e.toString()));
    }
  };
}
