import 'package:purala/models/files_related_morphs_model.dart';
import 'package:purala/models/file_model.dart';
import 'package:purala/repositories/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FileRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final _storageRepo = StorageRepository();

  Future<FileModel> getOne(int id, String relatedType) async {

    final res = await _db
    .from('files_related_morphs')
    .select('''
      files(
        id,
        name,
        caption,
        url,
        alternative_text,
        ext,
        created_at,
        updated_at,
        created_by_id,
        height,
        width
      )
    ''')
    .eq('related_id', id)
    .eq('related_type', relatedType).single();

    return FileModel.fromJson(res['files']);
  }

  Future<void> add(FileModel file, int relatedId, String relatedType) async {
    final res = await _db.from('files')
    .insert({
      'name': file.name,
      'caption': file.caption,
      'url': file.url,
      'alternative_text': file.alternativeText,
      'created_at': file.createdAt,
      'created_by_id': 1, // default admin id
      'ext': file.ext,
      'hash': file.hash,
      'updated_at': file.updatedAt
    }).select().single();

    await _db.from('files_related_morphs')
    .insert({
      'file_id': res['id'],
      'related_id': relatedId,
      'related_type': relatedType,
      'field': 'image', // default strapi field
      'order': 1 // default strapi order
    });
  }

  Future<void> update(FileModel file, int relatedId, String relatedType) async {
    final morph = await _db
    .from('files_related_morphs')
    .select('*')
    .eq('related_id', relatedId)
    .eq('related_type', relatedType).maybeSingle();

    if (morph == null) {
      await add(file, relatedId, relatedType);
    } else {
      final morphs = FilesRelatedMorphsModel.fromJson(morph);
      await _db.from('files')
      .update({
        'name': file.name,
        'caption': file.caption,
        'url': file.url,
        'alternative_text': file.alternativeText,
        'created_at': file.createdAt,
        'created_by_id': 1, // default admin id
        'ext': file.ext,
        'hash': file.hash,
        'updated_at': file.updatedAt
      }).eq('id', morphs.fileId);
    }
  }

  Future<void> delete(FileModel file, int relatedId, String relatedType) async {

    await _db.from('files')
    .delete().eq('id', file.id);

    await _db.from('files_related_morphs')
    .delete()
    .eq('related_id', relatedId)
    .eq('related_type', relatedType);

    await _storageRepo.delete(file.name, relatedType);
  }
}