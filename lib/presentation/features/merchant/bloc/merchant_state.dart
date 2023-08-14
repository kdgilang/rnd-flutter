import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/features/merchant/data/models/merchant_model.dart';

abstract class MerchantState extends Equatable {
  final MerchantModel ? data;
  final GraphQLError ? error;

  const MerchantState({ this.data, this.error });

  @override
  List<Object> get props => [data!, error!];
}

class StarterLoading extends MerchantState {
  const StarterLoading();
}

class StarterDone extends MerchantState {
  const StarterDone(MerchantModel data) : super(data: data); 
}

class StarterError extends MerchantState {
  const StarterError(GraphQLError? error) : super(error: error);
}