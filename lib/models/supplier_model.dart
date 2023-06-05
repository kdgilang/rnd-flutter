import 'package:purala/models/base_model.dart';

class SupplierModel extends BaseModel {
  final String name;
  final String? address;
  final String? phone;

  const SupplierModel({
    super.id,
    required this.name,
    this.address,
    this.phone,
  });

  SupplierModel copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
  }) {
    return SupplierModel(
      id: id ?? this.id,
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
    );
  }
}