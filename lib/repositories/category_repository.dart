import 'package:purala/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<List<CategoryModel>> getAll(int merchanId) async {
    var res = await _db
    .from('categories')
    .select('''
      *,
      categories_merchant_links(
        merchants(
          id
        )
      ),
      categories_user_links(
        up_users(
          id
        )
      )
    ''')
    .eq('categories_merchant_links.merchants.id', merchanId)
    .order('updated_at');
    
    List<CategoryModel> categories = [];

    for (var item in res) {
      final category = CategoryModel.fromJson(item);
      categories.add(category);
    }

    return categories;
  }

  Future<int> add(CategoryModel category) async {

    // final newcategory = await _db
    // .from('categorys')
    // .insert({
    //   'name': category.name,
    //   'description': category.description,
    //   'price': category.price,
    //   'normal_price': category.normalPrice,
    //   'quantity': category.quantity,
    //   'quantity_notify': category.quantityNotify,
    //   'enabled': category.enabled,
    //   'created_at': DateTime.now().toString(),
    //   'updated_at': DateTime.now().toString(),
    //   'published_at': DateTime.now().toString(),
    //   'created_by_id': 1 // default admin id
    // }).select().single();

    // final int categoryId = newcategory['id'];

    // await _db
    // .from('categorys_user_links')
    // .insert({
    //   'category_id': categoryId,
    //   'user_id': category.userId,
    // });

    // await _db
    // .from('categorys_merchant_links')
    // .insert({
    //   'category_id': categoryId,
    //   'merchant_id': category.merchantId, 
    // });

    return 1;
  }

  Future<void> update(CategoryModel category) async {
    // await _db
    //   .from('categorys')
    //   .update({
    //     'name': category.name,
    //     'description': category.description,
    //     'price': category.price,
    //     'normal_price': category.normalPrice,
    //     'quantity': category.quantity,
    //     'quantity_notify': category.quantityNotify,
    //     'enabled': category.enabled,
    //     'updated_at': DateTime.now().toString()
    //   })
    //   .eq('id', category.id);
  }

  Future<void> delete(CategoryModel category) async {
    await _db
    .from('categories_user_links')
    .delete().eq('category_id', category.id);    

    await _db
    .from('categories_merchant_links')
    .delete().eq('category_id', category.id);

    await _db
      .from('categories')
      .delete()
      .eq('id', category.id);
  }
}