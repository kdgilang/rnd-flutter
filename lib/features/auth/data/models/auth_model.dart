class AuthModel {

  AuthModel({
    required this.jwt
  });

  final String jwt;

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      jwt: json['login']?['jwt'] ?? ''
    );
  }
}