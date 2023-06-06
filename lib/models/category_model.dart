import 'package:purala/models/base_model.dart';

class CategoryModel extends BaseModel {
  final String name;
  final String? description;

  const CategoryModel({
    super.id,
    this.description,
    required this.name,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? description
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}