import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purala/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepository {

  final SupabaseClient _db = Supabase.instance.client;

  Future<FileResponse> upload(String name, File file, String? bucketId) async {
    name = "${DateTime.now().millisecondsSinceEpoch}_$name";
    bucketId = bucketId == UserModel.type ? "avatars" : "uploads";

    final String path = await _db.storage.from(bucketId).upload(
      name,
      file,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );


    final url = "${dotenv.env['SUPABASE_STORAGE_URL']}/$path";

    return FileResponse(name: name, url: url);
  }

  Future<void> delete(String fileName, String? bucketId) async {
    bucketId = bucketId == UserModel.type ? "avatars" : "uploads";
    await _db.storage
    .from(bucketId)
    .remove([fileName]);
  }
}

class FileResponse {
  final String name;
  final String url;

  FileResponse({
    required this.name,
    required this.url
  });
}