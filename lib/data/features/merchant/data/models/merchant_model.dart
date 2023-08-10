import 'package:purala/data/features/merchant/domain/entities/merchant_entity.dart';

class MerchantModel extends MerchantEntity {

  MerchantModel({
    required super.id,
    required super.name,
    super.description,
    super.media
  });

  factory MerchantModel.fromJson(Map<String, dynamic> merchant) {
    return MerchantModel(
      id: merchant['id'],
      name: merchant['name'],
      description: merchant['description'],
    );
  }

  static const type = 'api::merchant.merchant';
}