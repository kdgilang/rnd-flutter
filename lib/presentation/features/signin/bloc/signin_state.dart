import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/auth/data/models/auth_model.dart';

abstract class SigninState extends Equatable {
  final DataState<AuthModel> ? data;
  final GraphQLError ? error;

  const SigninState({ this.data, this.error });

  @override
  List<Object> get props => [data!, error!];
}

class SigninInitial extends SigninState {
  const SigninInitial();
}

class SigninLoading extends SigninState {
  const SigninLoading();
}

class SigninDone extends SigninState {
  const SigninDone(DataState<AuthModel> data) : super(data: data); 
}

class SigninError extends SigninState {
  const SigninError(GraphQLError? error) : super(error: error);
}