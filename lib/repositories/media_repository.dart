import 'package:purala/models/files_related_morphs_model.dart';
import 'package:purala/models/media_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MediaRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<MediaModel> getOne(int id, String type) async {

    final morphs = FilesRelatedMorphsModel.fromJson(await _db
    .from('files_related_morphs')
    .select('*')
    .eq('related_id', id)
    .eq('related_type', type).maybeSingle());

    final media = await _db
    .from('files')
    .select('id, name, caption, url, formats')
    .eq('id', morphs.fileId).maybeSingle();

    return MediaModel.fromJson(media);
  }
}