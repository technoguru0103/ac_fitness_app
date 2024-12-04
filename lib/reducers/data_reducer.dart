import '../models/data_state.dart';
import '../actions/data_actions.dart';

DataState dataReducer(DataState state, dynamic action) {
  if (action is FetchDataAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is FetchDataSuccessAction) {
    return state.copyWith(data: action.data, isLoading: false, error: null);
  } else if (action is FetchDataFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  }
  return state;
}
