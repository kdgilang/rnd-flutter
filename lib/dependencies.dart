import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/core/providers/strapi_graphql.dart';
import 'package:purala/features/auth/data/repositories/auth_repository.dart';
import 'package:purala/features/auth/domain/repositories/auth_repository.dart';
import 'package:purala/features/auth/domain/usecases/auth_usecase.dart';
import 'package:purala/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Providers
  sl.registerSingleton<GraphQLClient>(graphQLClient);

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl()));

  // Blocs
  sl.registerSingleton<AuthBloc>(AuthBloc(sl()));
}