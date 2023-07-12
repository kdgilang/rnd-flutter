import 'package:purala/models/stock_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StockRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<List<StockModel>> getAll(int merchantId) async {
    var res = await _db
    .from('stocks')
    .select('''
      *,
      stocks_merchant_links(
        merchants(
          id
        )
      ),
      stocks_user_links(
        up_users(
          id
        )
      ),
      stocks_product_links(
        products(
          name
        )
      ),
      stocks_supplier_links(
        suppliers(
          name
        )
      )
    ''')
    .eq('stocks_merchant_links.merchants.id', merchantId)
    .order('updated_at');
    
    List<StockModel> stocks = [];

    for (var item in res) {
      final product = StockModel.fromJson(item);
      stocks.add(product);
    }

    return stocks;
  }

  Future<int> add(StockModel product) async {

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

  Future<void> update(StockModel product) async {
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

  Future<void> delete(StockModel stock) async {
    await _db
    .from('stocks_user_links')
    .delete().eq('stock_id', stock.id);    

    await _db
    .from('stocks_merchant_links')
    .delete().eq('stock_id', stock.id);

    await _db
      .from('stocks')
      .delete()
      .eq('id', stock.id);
  }
}