abstract class AuthEvent {
  const AuthEvent();

  List<Object?> get props => [];
}

class OnAuth extends AuthEvent {
  const OnAuth({ required this.identifier, required this.password });

  final String identifier;
  final String password;

  @override
  List<Object?> get props => [identifier, password];
}