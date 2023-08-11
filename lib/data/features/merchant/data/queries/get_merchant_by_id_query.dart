class GetMerchantByIdParams {
  const GetMerchantByIdParams({ required this.id });

  final String id;
}

String getMerchantByIdQuery = """
  query getMerchantById(\$id: ID!) {
    merchant(id: \$id) {
      data {
        id,
        attributes {
          name,
          description,
          updatedAt,
          createdAt,
          image {
            data {
              attributes {
                url,
                name,
                size,
                alternativeText,
              }
            }
          }
        }
      }
    }
  }
""";
