import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/core/resources/usecase.dart';
import 'package:purala/data/features/merchant/data/models/merchant_model.dart';
import 'package:purala/data/features/merchant/data/queries/get_merchant_by_id_query.dart';
import 'package:purala/data/features/merchant/domain/repositories/merchant_repository.dart';

class GetMerchantByIdUseCase implements UseCase<void, GetMerchantByIdParams> {
  final MerchantRepository _merchantRepository;
  
  GetMerchantByIdUseCase(this._merchantRepository);

  @override
  Future<DataState<MerchantModel>> exec({ GetMerchantByIdParams? params }) {
    return _merchantRepository.get(params!);
  }
}