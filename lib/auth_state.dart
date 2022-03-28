abstract class AuthState {
  const AuthState();
}

class AuthStateUnknown extends AuthState {
  const AuthStateUnknown();
}

class Authenticated extends AuthState {
  final String userId;
  const Authenticated(this.userId);
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}
