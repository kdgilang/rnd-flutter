import 'package:purala/data/core/entities/base_entities.dart';

class SupplierModel extends BaseEntity {
  final String name;
  final int merchantId;
  final int userId;
  final String? address;
  final String? phone;

  const SupplierModel({
    super.id,
    required this.name,
    required this.merchantId,
    required this.userId,
    this.address,
    this.phone,
  });

  SupplierModel copyWith({
    int? id,
    int? merchantId,
    int? userId,
    String? name,
    String? address,
    String? phone,
  }) {
    return SupplierModel(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      merchantId: json['suppliers_merchant_links'][0]?['merchants']?['id'] ?? 0,
      userId: json['suppliers_user_links']?[0]?['up_users']?['id'] ?? 0,
    );
  }
}