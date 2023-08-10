class GetMerchantByIdParams {
  const GetMerchantByIdParams({ required this.id });

  final String id;
}

String getMerchantByIdQuery = """
  mutation login(\$identifier: String!, \$password: String!) {
    login(input: { identifier: \$identifier, password: \$password }) {
      jwt
    }
  }
""";
