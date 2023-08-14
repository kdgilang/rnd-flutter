import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purala/data/features/merchant/data/queries/get_merchant_by_id_query.dart';
import 'package:purala/data/features/merchant/domain/usecases/get_merchant_by_id_usecase.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_event.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  final GetMerchantByIdUseCase _getMerchantByIdUseCase;

  MerchantBloc(this._getMerchantByIdUseCase) : super(const StarterLoading()) {
    on <FetchData> (fetchData);
  }

  Future<void> fetchData(FetchData event, Emitter<MerchantState> emit) async {
    emit(const StarterLoading());
    final params = GetMerchantByIdParams(id: event.id);
    final res = await _getMerchantByIdUseCase.exec(params: params);

    if (res.error != null) {
      emit(StarterError(res.error));
    } else {
      emit(StarterDone(res.data!));
    }
  }
}