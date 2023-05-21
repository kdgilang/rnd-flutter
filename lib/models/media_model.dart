class MediaModel {
  final int id;
  final String name;
  final String? caption;
  final String url;
  final String thumbnailUrl;

  const MediaModel({
    required this.id,
    required this.name,
    this.caption,
    required this.url,
    required this.thumbnailUrl
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      name: json['name'],
      caption: json['caption'],
      url: json['url'],
      thumbnailUrl: json['formats']['thumbnail']['url']
    );
  }
}