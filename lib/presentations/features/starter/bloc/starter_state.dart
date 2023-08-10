import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/merchant/data/models/merchant_model.dart';

abstract class StarterState extends Equatable {
  final DataState<MerchantModel> ? data;
  final GraphQLError ? error;

  const StarterState({ this.data, this.error });

  @override
  List<Object> get props => [data!, error!];
}

class StarterLoading extends StarterState {
  const StarterLoading();
}

class StarterDone extends StarterState {
  const StarterDone(DataState<MerchantModel> data) : super(data: data); 
}

class StarterError extends StarterState {
  const StarterError(GraphQLError? error) : super(error: error);
}