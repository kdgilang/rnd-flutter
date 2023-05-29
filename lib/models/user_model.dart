import 'package:purala/models/base_model.dart';
import 'package:purala/models/media_model.dart';

class UserModel extends BaseModel {
  final String name;
  final String email;
  final bool confirmed;
  final bool blocked;
  final String role;
  final String ssoId;
  final int merchantId;
  final String? password;
  MediaModel? image;

  UserModel({
    required super.id,
    required this.name,
    required this.email,
    required this.confirmed,
    required this.blocked,
    required this.role,
    required this.ssoId,
    required this.merchantId,
    super.createdAt,
    super.updatedAt,
    this.image,
    this.password
  });

  UserModel copyWith({int? id, String? name, String? email, bool? confirmed, bool? blocked, String? role, String? ssoId, int? merchantId, MediaModel? image}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
      role: role ?? this.role,
      ssoId: ssoId ?? this.ssoId,
      merchantId: merchantId ?? this.merchantId,
      image: image ?? this.image
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['username'],
      email: json['email'],
      confirmed: json['confirmed'],
      blocked: json['blocked'],
      role: json['up_users_role_links'][0]['up_roles']?['type'],
      ssoId: json['sso_id'],
      merchantId: json['up_users_merchant_links'][0]?['merchants']?['id'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      password: ''
    );
  }
}