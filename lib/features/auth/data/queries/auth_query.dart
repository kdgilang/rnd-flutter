class AuthParams {
  const AuthParams({ required this.identifier, required this.password });

  final String identifier;
  final String password;
}

String loginQuery = """
  mutation login(\$identifier: String!, \$password: String!) {
    login(input: { identifier: \$identifier, password: \$password }) {
      jwt
    }
  }
""";
