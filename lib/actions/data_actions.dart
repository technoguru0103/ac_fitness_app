class FetchDataAction {}

class FetchDataSuccessAction {
  final List<dynamic> data;

  FetchDataSuccessAction(this.data);
}

class FetchDataFailureAction {
  final String error;

  FetchDataFailureAction(this.error);
}
