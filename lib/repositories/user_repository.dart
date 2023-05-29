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

    final media = await mediaRepo.getOne(user.id, 'plugin::users-permissions.user');

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
      final media = await mediaRepo.getOne(user.id, 'plugin::users-permissions.user');
      user.image = media;
      users.add(user);
    }

    return users;
  }

  Future<void> update(UserModel user) async {
    await _db
      .from('up_users')
      .update({
        'username': user.name,
        'blocked': user.blocked,
        'password': user.password,
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