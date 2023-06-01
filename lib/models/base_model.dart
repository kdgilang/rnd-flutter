class BaseModel {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final int? createdById; 

  const BaseModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdById
  });
}