class AuthState {
  final bool isAuthenticated;
  final String? token; // Token from the backend
  final bool isLoading; // For async requests
  final String? message; // message messages

  AuthState({
    required this.isAuthenticated,
    this.token,
    required this.isLoading,
    this.message,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuthenticated: false,
      token: null,
      isLoading: false,
      message: null,
    );
  }

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    bool? isLoading,
    String? message,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      message: message,
    );
  }
}
