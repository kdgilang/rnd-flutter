import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purala/data/features/auth/data/queries/auth_query.dart';
import 'package:purala/data/features/auth/domain/usecases/auth_usecase.dart';
import 'package:purala/presentation/features/signin/bloc/signin_event.dart';
import 'package:purala/presentation/features/signin/bloc/signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthUseCase _authUseCase;

  SigninBloc(this._authUseCase) : super(const SigninInitial()) {
    on <Auth> (auth);
  }

  Future<void> auth(Auth event, Emitter<SigninState> emit) async {
    emit(const SigninLoading());
    final params = AuthParams(identifier: event.identifier, password: event.password);
    final res = await _authUseCase.exec(params: params);

    if (res.error != null) {
      emit(SigninError(res.error));
    } else {
      emit(SigninDone(res));
    }
  }
}