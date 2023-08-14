abstract class SigninEvent {
  const SigninEvent();

  List<Object?> get props => [];
}

class Auth extends SigninEvent {
  const Auth({ required this.identifier, required this.password });

  final String identifier;
  final String password;

  @override
  List<Object?> get props => [identifier, password];
}