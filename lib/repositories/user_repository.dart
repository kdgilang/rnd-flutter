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

    final media = await mediaRepo.getOne(user.id!, 'plugin::users-permissions.user');

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
      final media = await mediaRepo.getOne(user.id!, 'plugin::users-permissions.user');
      user.image = media;
      users.add(user);
    }

    return users;
  }

  Future<void> add(UserModel user) async {
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
      'updated_at': DateTime.now().toString()
    }).select();

    mediaRepo.add(
      MediaModel(
        name: user.image!.name,
        url: user.image!.url,
        size: user.image!.size,
        caption: user.name,
        ext: user.image!.ext,
        alternativeText: user.image!.alternativeText
      )
      , newUSer.id, 'plugin::users-permissions.user');

    await _db
    .from('up_users_role_links')
    .insert({
      'user_id': newUSer.id,
      'role_id': 4, // default editor
      'user_order': 1,
    });

    await _db
    .from('up_users_role_links')
    .insert({
      'user_id': newUSer.id,
      'merchant_id': user.merchantId, 
    });
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

  Future<void> delete(int userId) async {
    await _db
      .from('up_users')
      .delete()
      .eq('id', userId);
  }
}