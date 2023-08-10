import 'package:purala/data/core/resources/data_state.dart';
import 'package:purala/data/features/merchant/data/models/merchant_model.dart';
import 'package:purala/data/features/merchant/data/queries/get_merchant_by_id_query.dart';

abstract class MerchantRepository {
  Future<DataState<MerchantModel>> get(GetMerchantByIdParams params);
}