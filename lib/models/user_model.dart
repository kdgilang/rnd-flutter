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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['username'],
      email: json['email'],
      confirmed: json['confirmed'],
      blocked: json['blocked'],
      role: json['up_users_role_links'][0]['up_roles']?['type'],
      ssoId: json['sso_id'],
      merchantId: json['up_users_merchant_links'][0]?['merchants']?['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at'])
    );
  }
}