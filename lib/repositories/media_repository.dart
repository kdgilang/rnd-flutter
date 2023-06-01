import 'package:purala/models/files_related_morphs_model.dart';
import 'package:purala/models/media_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MediaRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<MediaModel> getOne(int id, String relatedType) async {

    final morphs = FilesRelatedMorphsModel.fromJson(await _db
    .from('files_related_morphs')
    .select('*')
    .eq('related_id', id)
    .eq('related_type', relatedType).maybeSingle());

    final media = await _db
    .from('files')
    .select('id, name, caption, url')
    .eq('id', morphs.fileId).maybeSingle();

    return MediaModel.fromJson(media);
  }

  Future<void> add(MediaModel media, int relatedId, String relatedType) async {
    final fileId = await _db.from('files')
    .insert(media);

    await _db.from('files_related_morphs')
    .insert({
      'file_id': fileId,
      'related_id': relatedId,
      'related_type': relatedType,
      'field': '',
      'order': 0
    });
  }
}