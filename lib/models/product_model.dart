import 'package:purala/models/base_model.dart';
import 'package:purala/models/file_model.dart';

class ProductModel extends BaseModel {
  final String name;
  final String description;
  final double price;
  final double normalPrice;
  final int quantity;
  final int? quantityNotify;
  final int merchantId;
  final String? publishedAt;
  final bool enabled;
  FileModel? image;

  ProductModel({
    super.id,
    required this.name,
    required this.description,
    required this.price,
    required this.normalPrice,
    required this.quantity,
    required this.merchantId,
    super.createdAt,
    super.updatedAt,
    super.createdById,
    this.image,
    this.publishedAt,
    this.quantityNotify,
    required this.enabled
  });

  static const String type = 'api::product.product';

  ProductModel copyWith({
    String? name,
    String? description,
    double? price,
    double? normalPrice,
    int? quantity,
    int? quantityNotify,
    int? merchantId,
    String? publishedAt,
    FileModel? image,
    String? createdAt,
    String? updatedAt,
    int? createdById,
    bool? enabled,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      normalPrice: normalPrice ?? this.normalPrice,
      quantity: quantity ?? this.quantity,
      quantityNotify: quantityNotify ?? this.quantityNotify,
      publishedAt: publishedAt ?? this.publishedAt,
      merchantId: merchantId ?? this.merchantId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdById: createdById ?? this.createdById,
      image: image ?? this.image,
      enabled: enabled ?? this.enabled,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      normalPrice: json['normal_price'],
      quantity: json['quantity'],
      quantityNotify: json['quantity_notify'],
      publishedAt: json['published_at'],
      merchantId: json['products_merchant_links'][0]?['merchants']?['id'] ?? 0,
      createdAt: json['created_at'] ?? DateTime.now().toString(),
      updatedAt: json['updated_at'] ?? DateTime.now().toString(),
      createdById: json['created_by_id'],
      enabled: json['enabled'],
    );
  }
}