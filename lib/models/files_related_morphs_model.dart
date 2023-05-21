class FilesRelatedMorphsModel {
  final int id;
  final int fileId;
  final int relatedId;
  final String relatedType;
  final String field;
  final int order;

  const FilesRelatedMorphsModel({
    required this.id,
    required this.fileId,
    required this.relatedId,
    required this.relatedType,
    required this.field,
    required this.order
  });

  factory FilesRelatedMorphsModel.fromJson(Map<String, dynamic> json) {
    return FilesRelatedMorphsModel(
      id: json['id'],
      fileId: json['file_id'],
      relatedId: json['related_id'],
      relatedType: json['related_type'],
      field: json['field'],
      order: json['order'],
    );
  }
}