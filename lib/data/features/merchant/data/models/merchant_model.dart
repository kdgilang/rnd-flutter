import 'package:purala/data/features/merchant/domain/entities/merchant_entity.dart';
import 'package:purala/models/file_model.dart';

class MerchantModel extends MerchantEntity {

  MerchantModel({
    required super.id,
    required super.name,
    super.description,
    super.image
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: int.tryParse(json['id']),
      name: json['attributes']['name'] ?? '',
      description: json['attributes']?['description'],
      image: FileModel(
        url: json['attributes']?['image']?['data']?['attributes']?['url'] ?? '',
        name: json['attributes']?['image']?['data']?['attributes']?['name'] ?? '',
        alternativeText: json['attributes']?['image']?['data']?['attributes']?['alternativeText'] ?? ''
      ) 
    );
  }

  static const type = 'merchant';
}