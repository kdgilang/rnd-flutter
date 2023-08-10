import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purala/data/features/auth/data/queries/auth_query.dart';
import 'package:purala/data/features/auth/domain/usecases/auth_usecase.dart';
import 'package:purala/presentations/features/signin/bloc/auth_event.dart';
import 'package:purala/presentations/features/signin/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(const AuthInitial()) {
    on <OnAuth> (onAuthAuth);
  }

  Future<void> onAuthAuth(OnAuth event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    Future.delayed(const Duration(milliseconds: 10000));
    final params = AuthParams(identifier: event.identifier, password: event.password);
    final res = await _authUseCase.exec(params: params);

    if (res.error != null) {
      emit(AuthError(res.error));
    } else {
      emit(AuthDone(res));
    }
  }
}