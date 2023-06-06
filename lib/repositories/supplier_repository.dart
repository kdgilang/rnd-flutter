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

  Future<int> add(SupplierModel supplier) async {

    final res = await _db
    .from('suppliers')
    .insert({
      'name': supplier.name,
      'phone': supplier.phone,
      'address': supplier.address,
      'created_at': DateTime.now().toString(),
      'updated_at': DateTime.now().toString(),
      'created_by_id': 1 // default admin id
    }).select().single();

    final int id = res['id'];

    await _db
    .from('suppliers_user_links')
    .insert({
      'supplier_id': id,
      'user_id': supplier.userId,
    });

    await _db
    .from('suppliers_merchant_links')
    .insert({
      'supplier_id': id,
      'merchant_id': supplier.merchantId, 
    });

    return 1;
  }

  Future<void> update(SupplierModel supplier) async {
    await _db
      .from('suppliers')
      .update({
        'name': supplier.name,
        'phone': supplier.phone,
        'address': supplier.address,
        'updated_at': DateTime.now().toString()
      })
      .eq('id', supplier.id);
  }

  Future<void> delete(SupplierModel supplier) async {
    await _db
    .from('suppliers_user_links')
    .delete().eq('supplier_id', supplier.id);    

    await _db
    .from('suppliers_merchant_links')
    .delete().eq('supplier_id', supplier.id);

    await _db
      .from('suppliers')
      .delete()
      .eq('id', supplier.id);
  }
}