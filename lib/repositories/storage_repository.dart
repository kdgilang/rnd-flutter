import 'dart:io';

import 'package:purala/models/merchant_model.dart';
import 'package:purala/repositories/media_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepository {

  final SupabaseClient _db = Supabase.instance.client;
  final mediaRepo = MediaRepository();

  Future<String> upload(String name, File file) async {

    final String path = await _db.storage.from('avatars').upload(
      name,
      file,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );

    return path;
  }
}