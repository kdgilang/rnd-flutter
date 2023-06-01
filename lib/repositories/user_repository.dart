import 'package:purala/models/media_model.dart';
import 'package:purala/models/user_model.dart';
import 'package:purala/repositories/media_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final mediaRepo = MediaRepository();

  Future<UserModel> getBySsoId(String ssoId) async {
    var res = await _db
    .from('up_users')
    .select('''
      *,
      up_users_merchant_links (
        merchants (
          id
        )
      ),
      up_users_role_links (
        up_roles (
          type
        )
      )
    ''')
    .eq('sso_id', ssoId).single();


    final user = UserModel.fromJson(res);

    final media = await mediaRepo.getOne(user.id!, UserModel.type);

    user.image = media;

    return user;
  }

  Future<List<UserModel>> getAll(int merchanId) async {
    var res = await _db
    .from('up_users')
    .select('''
      *,
      up_users_merchant_links (
        merchants (
          id
        )
      ),
      up_users_role_links (
        up_roles (
          type
        )
      )
    ''')
    .eq('up_users_merchant_links.merchants.id', merchanId);
    
    List<UserModel> users = [];

    for (var item in res) {
      final user = UserModel.fromJson(item);
      final media = await mediaRepo.getOne(user.id!, UserModel.type);
      user.image = media;
      users.add(user);
    }

    return users;
  }

  Future<int> add(UserModel user) async {
    final AuthResponse res = await _db.auth.signUp(
      email: user.email,
      password: user.password!,
      data: {
        'confirmation_sent_at': DateTime.now().toString(),
      }
    );

    final newUSer = await _db
    .from('up_users')
    .insert({
      'username': user.name,
      'email': user.email,
      'confirmed': user.confirmed,
      'blocked': user.blocked,
      'sso_id': res.user!.id,
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'created_by_id': 1 // default admin id
    }).select().single();

    final int userId = newUSer['id'];

    await _db
    .from('up_users_role_links')
    .insert({
      'user_id': userId,
      'role_id': 4, // default editor
      'user_order': 1,
    });

    await _db
    .from('up_users_merchant_links')
    .insert({
      'user_id': userId,
      'merchant_id': user.merchantId, 
    });

    return userId;
  }

  Future<void> update(UserModel user) async {
    await _db
      .from('up_users')
      .update({
        'username': user.name,
        'blocked': user.blocked,
        'updated_at': DateTime.now().toString()
      })
      .eq('id', user.id);
  }

  Future<void> delete(UserModel user) async {
    await _db.auth.admin.deleteUser(user.ssoId!);
    
    await _db
    .from('up_users_role_links')
    .delete().eq('id', user.id);

    await _db
    .from('up_users_merchant_links')
    .delete().eq('id', user.id);

    await mediaRepo.delete(user.image!, user.id!, UserModel.type);

    await _db
      .from('up_users')
      .delete()
      .eq('id', user.id);
  }
}