import 'package:purala/data/core/entities/base_entities.dart';
import 'package:purala/models/file_model.dart';

class MerchantModel extends BaseEntity {
  final String name;
  final String? description;
  FileModel? media;

  MerchantModel({
    required super.id,
    required this.name,
    this.description,
    this.media
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