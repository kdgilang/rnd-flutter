import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/auth/data/models/auth_model.dart';
import 'package:purala/data/features/auth/data/queries/auth_query.dart';

abstract class AuthRepository {
  Future<DataState<AuthModel>> auth(AuthParams params);
}