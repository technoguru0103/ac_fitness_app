class AuthState {
  final bool isAuthenticated;
  final String? token; // Token from the backend
  final bool isLoading; // For async requests
  final String? error; // Error messages

  AuthState({
    required this.isAuthenticated,
    this.token,
    required this.isLoading,
    this.error,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuthenticated: false,
      token: null,
      isLoading: false,
      error: null,
    );
  }

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
