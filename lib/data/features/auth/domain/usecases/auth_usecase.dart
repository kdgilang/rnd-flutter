import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/core/resources/usecase.dart';
import 'package:purala/data/features/auth/data/models/auth_model.dart';
import 'package:purala/data/features/auth/data/queries/auth_query.dart';
import 'package:purala/data/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase implements UseCase<void, AuthParams> {
  final AuthRepository _authRepository;
  
  AuthUseCase(this._authRepository);

  @override
  Future<DataState<AuthModel>> exec({ AuthParams? params }) {
    return _authRepository.auth(params!);
  }
}