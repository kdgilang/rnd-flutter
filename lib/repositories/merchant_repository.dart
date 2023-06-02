import 'package:purala/models/merchant_model.dart';
import 'package:purala/repositories/file_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MerchantRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final fileRepo = FileRepository();

  Future<MerchantModel> getOne(int id) async {

    var res = await _db
    .from('merchants')
    .select("*")
    .eq('id', id).maybeSingle();

    final media = await fileRepo.getOne(id, MerchantModel.type);
    final merchant = MerchantModel.fromJson(res);
    merchant.media = media;

    return merchant;
  }
}