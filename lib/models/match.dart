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

  Server.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        url = json['url'] ?? '',
        headers = _parseHeaders(json['headers']),
        isPremium = json['is_premium'],
        sportId = json['sport_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'headers': headers?.toString() ?? '',
      'is_premium': isPremium,
      'sport_id': sportId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static Map<String, String> _parseHeaders(String? stringHeaders) {
    Map<String, String> headersMap = {};
    if (stringHeaders != null &&
        stringHeaders.isNotEmpty &&
        stringHeaders.toLowerCase() != 'null') {
      List<String> firstSplit = stringHeaders.split('\n');
      firstSplit.forEach((element) {
        if (element.isNotEmpty) {
          List<String> secondSplit = element.replaceAll('"', '').split(': ');
          if (secondSplit.length == 2) {
            headersMap[secondSplit[0]] = secondSplit[1];
          }
        }
      });
    }
    return headersMap;
  }
}
