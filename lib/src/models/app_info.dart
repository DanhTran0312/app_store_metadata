/// Model representing app metadata
class AppInfo {
  final String id;
  final String name;
  final String developer;
  final String? description;
  final String? summary;
  final double? rating;
  final int? ratingCount;
  final String? price;
  final String? currency;
  final String? iconUrl;
  final List<String> screenshots;
  final String? category;
  final String? contentRating;
  final String? version;
  final String? lastUpdated;
  final String? downloadUrl;
  final int? downloads;
  final String? bundleId;
  final Map<String, dynamic>? additionalInfo;

  AppInfo({
    required this.id,
    required this.name,
    required this.developer,
    this.description,
    this.summary,
    this.rating,
    this.ratingCount,
    this.price,
    this.currency,
    this.iconUrl,
    List<String>? screenshots,
    this.category,
    this.contentRating,
    this.version,
    this.lastUpdated,
    this.downloadUrl,
    this.downloads,
    this.bundleId,
    this.additionalInfo,
  }) : screenshots = screenshots ?? [];

  /// Create AppInfo from JSON
  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      developer: json['developer'] as String,
      description: json['description'] as String?,
      summary: json['summary'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: json['ratingCount'] as int?,
      price: json['price'] as String?,
      currency: json['currency'] as String?,
      iconUrl: json['iconUrl'] as String?,
      screenshots: (json['screenshots'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      category: json['category'] as String?,
      contentRating: json['contentRating'] as String?,
      version: json['version'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      downloads: json['downloads'] as int?,
      bundleId: json['bundleId'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );
  }

  /// Convert AppInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'developer': developer,
      'description': description,
      'summary': summary,
      'rating': rating,
      'ratingCount': ratingCount,
      'price': price,
      'currency': currency,
      'iconUrl': iconUrl,
      'screenshots': screenshots,
      'category': category,
      'contentRating': contentRating,
      'version': version,
      'lastUpdated': lastUpdated,
      'downloadUrl': downloadUrl,
      'downloads': downloads,
      'bundleId': bundleId,
      'additionalInfo': additionalInfo,
    };
  }

  @override
  String toString() {
    return 'AppInfo(id: $id, name: $name, developer: $developer, rating: $rating)';
  }
}
