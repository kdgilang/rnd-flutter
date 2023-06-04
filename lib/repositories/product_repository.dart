import 'package:purala/models/product_model.dart';
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
        merchants(
          id
        )
      ),
      products_user_links(
        up_users(
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

  Future<int> add(ProductModel product) async {

    final newProduct = await _db
    .from('products')
    .insert({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'normal_price': product.normalPrice,
      'quantity': product.quantity,
      'quantity_notify': product.quantityNotify,
      'enabled': product.enabled,
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'published_at': DateTime.now().toString(),
      'created_by_id': 1 // default admin id
    }).select().single();

    final int productId = newProduct['id'];

    await _db
    .from('products_user_links')
    .insert({
      'product_id': productId,
      'user_id': product.userId,
    });

    await _db
    .from('products_merchant_links')
    .insert({
      'product_id': productId,
      'merchant_id': product.merchantId, 
    });

    return productId;
  }

  Future<void> update(ProductModel product) async {
    await _db
      .from('products')
      .update({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'normal_price': product.normalPrice,
        'quantity': product.quantity,
        'quantity_notify': product.quantityNotify,
        'enabled': product.enabled,
        'updated_at': DateTime.now().toString()
      })
      .eq('id', product.id);
  }

  Future<void> delete(ProductModel product) async {
    
    await _db
    .from('categories_products_links')
    .delete().eq('product_id', product.id);

    await _db
    .from('products_ingredients_links')
    .delete().eq('product_id', product.id);

    await _db
    .from('products_user_links')
    .delete().eq('product_id', product.id);    

    await _db
    .from('products_merchant_links')
    .delete().eq('product_id', product.id);

    if (product.image != null) {
      await fileRepo.delete(product.image!, product.id!, ProductModel.type);
    }

    await _db
      .from('products')
      .delete()
      .eq('id', product.id);
  }
}