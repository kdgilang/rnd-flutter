import 'package:purala/models/base_model.dart';

class MediaModel extends BaseModel {
  final String name;
  final String? caption;
  final String alternativeText;
  final String url;
  final String? hash;
  final String? mime;
  final String? ext;
  final int? size;
  final int? height;
  final int? width;

  const MediaModel({
    super.id,
    required this.name,
    required this.url,
    required this.alternativeText,
    super.createdAt,
    super.updatedAt,
    super.createdById,
    this.height,
    this.width,
    this.caption,
    this.hash,
    this.mime,
    this.ext,
    this.size
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      name: json['name'],
      caption: json['caption'],
      url: json['url'],
      alternativeText: json['alternative_text'] ?? "",
      hash: json['hash'],
      mime: json['mime'],
      ext: json['ext'],
      size: json['size'],
      createdAt: json['created_at'] ?? DateTime.now().toString(),
      updatedAt: json['updated_at'] ?? DateTime.now().toString(),
      createdById: json['created_by_id'],
      height: json['height'],
      width: json['width']
    );
  }
}