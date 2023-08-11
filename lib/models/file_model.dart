import 'package:purala/data/core/entities/base_entities.dart';

class FileModel extends BaseEntity {
  final String name;
  final String? caption;
  final String alternativeText;
  final String url;
  final String? hash;
  final String? mime;
  final String? ext;
  final num? size;
  final int? height;
  final int? width;

  const FileModel({
    super.id,
    required this.name,
    required this.url,
    required this.alternativeText,
    super.createdAt,
    super.updatedAt,
    super.createdById,
    this.size,
    this.height,
    this.width,
    this.caption,
    this.hash,
    this.mime,
    this.ext,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      caption: json['caption'],
      url: json['url'],
      alternativeText: json['alternative_text'] ?? "",
      hash: json['hash'],
      mime: json['mime'],
      ext: json['ext'],
      size: json['size'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      createdById: json['created_by_id'],
      height: json['height'],
      width: json['width']
    );
  }
}