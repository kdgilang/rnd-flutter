import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

late GraphQLClient graphQLClient;

Future<void> initGraphQL() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    dotenv.get('API_BASE_URL'),
  );

  final AuthLink authLink = AuthLink(
    getToken: () => "Bearer ${dotenv.get('API_TOKEN')}",
  );

  final Link link = authLink.concat(httpLink);

  graphQLClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  );
}