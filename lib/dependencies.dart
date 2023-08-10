import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:purala/data/core/providers/strapi_graphql.dart';
import 'package:purala/data/features/auth/data/repositories/auth_repository.dart';
import 'package:purala/data/features/auth/domain/repositories/auth_repository.dart';
import 'package:purala/data/features/auth/domain/usecases/auth_usecase.dart';
import 'package:purala/data/features/merchant/data/repositories/merchant_repository.dart';
import 'package:purala/data/features/merchant/domain/repositories/merchant_repository.dart';
import 'package:purala/data/features/merchant/domain/usecases/get_merchant_by_id_usecase.dart';
import 'package:purala/presentations/features/signin/bloc/auth_bloc.dart';
import 'package:purala/presentations/features/starter/bloc/starter_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Providers
  sl.registerSingleton<GraphQLClient>(graphQLClient);

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  sl.registerSingleton<MerchantRepository>(MerchantRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl()));
  sl.registerSingleton<GetMerchantByIdUseCase>(GetMerchantByIdUseCase(sl()));

  // Blocs
  sl.registerSingleton<AuthBloc>(AuthBloc(sl()));
  sl.registerSingleton<StarterBloc>(StarterBloc(sl()));
}