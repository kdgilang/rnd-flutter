import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/auth/data/models/auth_model.dart';

abstract class AuthState extends Equatable {
  final DataState<AuthModel> ? data;
  final GraphQLError ? error;

  const AuthState({ this.data, this.error });

  @override
  List<Object> get props => [data!, error!];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthDone extends AuthState {
  const AuthDone(DataState<AuthModel> data) : super(data: data); 
}

class AuthError extends AuthState {
  const AuthError(GraphQLError? error) : super(error: error);
}