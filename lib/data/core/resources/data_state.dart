import 'package:graphql_flutter/graphql_flutter.dart';

// centralized API response

abstract class DataState<T> {
  final T ? data;
  final GraphQLError ? error;

  const DataState({ this.data, this.error });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataException<T> extends DataState<T> {
  const DataException(GraphQLError error) : super(error: error);
}