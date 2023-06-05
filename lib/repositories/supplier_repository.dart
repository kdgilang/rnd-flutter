import 'package:purala/models/supplier_model.dart';
import 'package:purala/repositories/file_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupplierRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final fileRepo = FileRepository();

  Future<List<SupplierModel>> getAll(int merchanId) async {
    var res = await _db
    .from('suppliers')
    .select('''
      *,
      suppliers_merchant_links(
        merchants(
          id
        )
      ),
      suppliers_user_links(
        up_users(
          id
        )
      )
    ''')
    .eq('suppliers_merchant_links.merchants.id', merchanId)
    .order('updated_at');
    
    List<SupplierModel> suppliers = [];

    for (var item in res) {
      final supplier = SupplierModel.fromJson(item);
      suppliers.add(supplier);
    }

    return suppliers;
  }

  Future<int> add(SupplierModel product) async {

    // final newProduct = await _db
    // .from('products')
    // .insert({
    //   'name': product.name,
    //   'description': product.description,
    //   'price': product.price,
    //   'normal_price': product.normalPrice,
    //   'quantity': product.quantity,
    //   'quantity_notify': product.quantityNotify,
    //   'enabled': product.enabled,
    //   'created_at': DateTime.now().toString(),
    //   'updated_at': DateTime.now().toString(),
    //   'published_at': DateTime.now().toString(),
    //   'created_by_id': 1 // default admin id
    // }).select().single();

    // final int productId = newProduct['id'];

    // await _db
    // .from('products_user_links')
    // .insert({
    //   'product_id': productId,
    //   'user_id': product.userId,
    // });

    // await _db
    // .from('products_merchant_links')
    // .insert({
    //   'product_id': productId,
    //   'merchant_id': product.merchantId, 
    // });

    return 1;
  }

  Future<void> update(SupplierModel product) async {
    // await _db
    //   .from('products')
    //   .update({
    //     'name': product.name,
    //     'description': product.description,
    //     'price': product.price,
    //     'normal_price': product.normalPrice,
    //     'quantity': product.quantity,
    //     'quantity_notify': product.quantityNotify,
    //     'enabled': product.enabled,
    //     'updated_at': DateTime.now().toString()
    //   })
    //   .eq('id', product.id);
  }

  Future<void> delete(SupplierModel stock) async {
    await _db
    .from('supplier_user_links')
    .delete().eq('stock_id', stock.id);    

    await _db
    .from('supplier_merchant_links')
    .delete().eq('stock_id', stock.id);

    await _db
      .from('supplier')
      .delete()
      .eq('id', stock.id);
  }
}