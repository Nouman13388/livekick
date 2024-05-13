// models/server.dart

class Server {
  int id;
  String name;
  String url;
  Map<String, String> headers;
  int? isPremium;
  int? sportId;
  String? createdAt;
  String? updatedAt;

  Server({
    required this.id,
    required this.name,
    required this.url,
    required this.headers,
    this.isPremium,
    this.sportId,
    this.createdAt,
    this.updatedAt,
  });

  // Add fromJson and toJson methods
}
