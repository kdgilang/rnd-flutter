import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/auth/data/models/auth_model.dart';
import 'package:purala/data/features/auth/data/queries/auth_query.dart';
import 'package:purala/data/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GraphQLClient _client;

  const AuthRepositoryImpl(this._client);

  @override
  Future<DataState<AuthModel>> auth(AuthParams params) async {
    try {
      final graphQLClient = await _client.query(
        QueryOptions(
          document: gql(authQuery),
          variables: {
            'identifier': params.identifier,
            'password': params.password
          },
        ),
      );

      if (graphQLClient.hasException) {
        return DataException(
          GraphQLError(
            message: graphQLClient.exception.toString(),
            path: graphQLClient.exception!.raw,
          )
        );
      } else {
        final data = AuthModel.fromJson(graphQLClient.data!);
        return DataSuccess(data);
      }
    } on GraphQLError catch(e) {
      return DataException(e);
    }
  }
}