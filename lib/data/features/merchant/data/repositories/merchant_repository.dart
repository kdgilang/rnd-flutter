import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/merchant/data/models/merchant_model.dart';
import 'package:purala/data/features/merchant/data/queries/get_merchant_by_id_query.dart';
import 'package:purala/data/features/merchant/domain/repositories/merchant_repository.dart';


class MerchantRepositoryImpl implements MerchantRepository {
  final GraphQLClient _client;

  const MerchantRepositoryImpl(this._client);

  @override
  Future<DataState<MerchantModel>> get(GetMerchantByIdParams params) async {
    try {
      final graphQLClient = await _client.query(
        QueryOptions(
          document: gql(getMerchantByIdQuery),
          variables: {
            'id': params.id
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
        final data = MerchantModel.fromJson(graphQLClient.data!['merchant']['data']!);
        return DataSuccess(data);
      }
    } on GraphQLError catch(e) {
      return DataException(e);
    } on Exception catch (e) {
      return DataException(
        GraphQLError(
          message: e.toString(),
        )
      );
    }
  }
}