import 'package:purala/data/core/entities/base_entities.dart';
import 'package:purala/models/file_model.dart';

class MerchantEntity extends BaseEntity {
  final String name;
  final String? description;
  FileModel? image;

  MerchantEntity({
    required super.id,
    required this.name,
    this.description,
    this.image
  });
}