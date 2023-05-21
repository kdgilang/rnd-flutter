import 'package:purala/models/base_model.dart';
import 'package:purala/models/media_model.dart';

class MerchantModel extends BaseModel {
  final String name;
  final String? description;
  final MediaModel? media;

  const MerchantModel({
    required super.id,
    required this.name,
    this.description,
    this.media
  });

  factory MerchantModel.fromJson(Map<String, dynamic> merchant, Map<String, dynamic> media) {
    return MerchantModel(
      id: merchant['id'],
      name: merchant['name'],
      description: merchant['description'],
      media: MediaModel.fromJson(media)
    );
  }
}