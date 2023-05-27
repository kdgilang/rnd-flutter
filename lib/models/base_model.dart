class BaseModel {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BaseModel({
    required this.id,
    this.createdAt,
    this.updatedAt
  });
}