import 'package:purala/models/product_model.dart';
import 'package:purala/models/user_model.dart';
import 'package:purala/repositories/file_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final fileRepo = FileRepository();

  Future<List<ProductModel>> getAllEnabled(int merchanId) async {
    var res = await _db
    .from('products')
    .select('''
      *,
      products_merchant_links(
        merchants (
          id
        )
      )
    ''')
    .eq('products_merchant_links.merchants.id', merchanId)
    .eq('enabled', true)
    .order('updated_at');
    
    List<ProductModel> products = [];

    for (var item in res) {
      final product = ProductModel.fromJson(item);
      final file = await fileRepo.getOne(product.id!, ProductModel.type);
      product.image = file;
      products.add(product);
    }

    return products;
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
        'confirmed': user.confirmed,
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

    await fileRepo.delete(user.image!, user.id!, UserModel.type);

    await _db
      .from('up_users')
      .delete()
      .eq('id', user.id);
  }
}