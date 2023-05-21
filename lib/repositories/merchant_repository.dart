import 'package:purala/models/files_related_morphs_model.dart';
import 'package:purala/models/merchant_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MerchantRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<MerchantModel> getOne(int id) async {

    var merchant = await _db
    .from('merchants')
    .select("*")
    .eq('id', id).maybeSingle();

    final morphs = FilesRelatedMorphsModel.fromJson(await _db
    .from('files_related_morphs')
    .select('*')
    .eq('related_id', id)
    .eq('related_type', 'api::merchant.merchant').maybeSingle());

    final media = await _db
    .from('files')
    .select('id, name, caption, url, formats')
    .eq('id', morphs.fileId).maybeSingle();

    return MerchantModel.fromJson(merchant, media);
  }
}