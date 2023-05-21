import 'package:purala/models/files_related_morphs_model.dart';
import 'package:purala/models/merchant_model.dart';
import 'package:purala/repositories/media_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MerchantRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final mediaRepo = MediaRepository();

  Future<MerchantModel> getOne(int id) async {

    var res = await _db
    .from('merchants')
    .select("*")
    .eq('id', id).maybeSingle();

    final media = await mediaRepo.getOne(id, 'api::merchant.merchant');
    final merchant = MerchantModel.fromJson(res);
    merchant.media = media;

    return merchant;
  }
}