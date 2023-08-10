class BaseEntity {
  final int? id;
  final String? createdAt;
  final String? updatedAt;
  final int? createdById;

  const BaseEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdById
  });
}