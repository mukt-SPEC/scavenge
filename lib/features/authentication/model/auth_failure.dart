sealed class AuthFailure implements Exception {
  final String message;
  const AuthFailure(this.message);

  @override
  String toString() => message;
}

class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure() : super('Please enter a valid email address.');
}

class UserDisabledFailure extends AuthFailure {
  const UserDisabledFailure()
    : super('This account has been disabled. Please contact support.');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure()
    : super('No account found with this email. Please sign up first.');
}

class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure()
    : super('Incorrect password. Please try again.');
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure()
    : super('This email is already registered. Please sign in instead.');
}

class OperationNotAllowedFailure extends AuthFailure {
  const OperationNotAllowedFailure()
    : super('Email/password accounts are not enabled. Please contact support.');
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure()
    : super('The password is too weak. Please use a stronger password.');
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure()
    : super('A network error occurred. Please check your connection and try again.');
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure() : super('An unexpected error occurred.');
}

class ResetPasswordFailure extends AuthFailure {
  const ResetPasswordFailure()
    : super('Could not send reset email. Please try again.');
}
