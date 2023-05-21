class MediaModel {
  final int id;
  final String name;
  final String? caption;
  final Uri imageUrl;
  final Uri thumbnailUrl;

  const MediaModel({
    required this.id,
    required this.name,
    this.caption,
    required this.imageUrl,
    required this.thumbnailUrl
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      name: json['name'],
      caption: json['caption'],
      imageUrl: Uri.parse(json['url']),
      thumbnailUrl: Uri.parse(json['formats']['thumbnail']['url'])
    );
  }
}