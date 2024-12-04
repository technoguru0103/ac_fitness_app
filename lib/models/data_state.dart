class DataState {
  final List<dynamic> data;
  final bool isLoading;
  final String? error;

  DataState({required this.data, required this.isLoading, this.error});

  factory DataState.initial() =>
      DataState(data: [], isLoading: false, error: null);

  DataState copyWith({List<dynamic>? data, bool? isLoading, String? error}) {
    return DataState(
        data: data ?? this.data,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
