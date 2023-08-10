import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purala/data/features/merchant/data/queries/get_merchant_by_id_query.dart';
import 'package:purala/data/features/merchant/domain/usecases/get_merchant_by_id_usecase.dart';
import 'package:purala/presentations/features/starter/bloc/starter_event.dart';
import 'package:purala/presentations/features/starter/bloc/starter_state.dart';

class StarterBloc extends Bloc<StarterEvent, StarterState> {
  final GetMerchantByIdUseCase _getMerchantByIdUseCase;

  StarterBloc(this._getMerchantByIdUseCase) : super(const StarterLoading()) {
    on <OnMounted> (onMounted);
  }

  Future<void> onMounted(OnMounted event, Emitter<StarterState> emit) async {
    emit(const StarterLoading());
    Future.delayed(const Duration(milliseconds: 10000));
    final params = GetMerchantByIdParams(id: event.id);
    final res = await _getMerchantByIdUseCase.exec(params: params);

    if (res.error != null) {
      emit(StarterError(res.error));
    } else {
      emit(StarterDone(res));
    }
  }
}