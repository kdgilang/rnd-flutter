import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<String> upload(String name, File file) async {

    final String path = await _db.storage.from('avatars').upload(
      name,
      file,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );

    return path;
  }

  Future<void> delete(String fileName) async {
    await _db.storage
    .from('avatars')
    .remove([fileName]);
  }
}