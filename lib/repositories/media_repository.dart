import 'package:purala/models/files_related_morphs_model.dart';
import 'package:purala/models/media_model.dart';
import 'package:purala/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MediaRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final storageRepo = StorageRepository();

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
    final file = await _db.from('files')
    .insert({
      'name': media.name,
      'caption': media.caption,
      'url': media.url,
      'alternative_text': media.alternativeText,
      'created_at': media.createdAt,
      'created_by_id': 1, // default admin id
      'ext': media.ext,
      'hash': media.hash,
      'size': media.size,
      'updated_at': media.updatedAt
    }).select().single();

    await _db.from('files_related_morphs')
    .insert({
      'file_id': file['id'],
      'related_id': relatedId,
      'related_type': relatedType,
      'field': 'image', // default strapi field
      'order': 1 // default strapi order
    });
  }

  Future<void> delete(MediaModel media, int relatedId, String relatedType) async {

    await _db.from('files')
    .delete().eq('id', media.id);

    await _db.from('files_related_morphs')
    .delete()
    .eq('related_id', relatedId)
    .eq('related_type', relatedType);

    await storageRepo.delete(media.name);
  }
}