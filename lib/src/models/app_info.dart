import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

part 'app_info.mapper.dart';

@MappableClass()
/// Model representing app metadata from both Apple App Store and Google Play Store
class AppInfo extends Equatable with AppInfoMappable {
  // Core Identity Fields
  final String id; // trackId for iOS, packageId for Android
  final String name; // trackName for iOS, app name for Android
  final String? trackCensoredName; // iOS only
  final String? bundleId; // iOS bundleId, Android packageId
  final String? kind; // iOS only (e.g., "software")
  final String? wrapperType; // iOS only (e.g., "software")

  // Developer/Publisher Information
  final String developer; // artistName for iOS, developer for Android
  final int? artistId; // iOS only
  final String? artistViewUrl; // iOS developer page URL
  final String? sellerName; // iOS only
  final String? sellerUrl; // iOS only

  // App Description & Content
  final String? description;
  final String? summary; // releaseNotes for iOS, summary for Android
  final String? releaseNotes; // iOS currentVersionReleaseDate notes

  // Ratings & Reviews (Overall)
  final double? rating; // averageUserRating
  final int? ratingCount; // userRatingCount

  // Ratings & Reviews (Current Version) - iOS only
  final double? currentVersionRating; // averageUserRatingForCurrentVersion
  final int? currentVersionRatingCount; // userRatingCountForCurrentVersion

  // Pricing Information
  final String? price; // formattedPrice for display
  final double? priceAmount; // actual price value
  final String? currency;

  // App Icons & Artwork
  final String? iconUrl; // artworkUrl512 preferred, fallback to others
  final String? artworkUrl60; // iOS only
  final String? artworkUrl100; // iOS only
  final String? artworkUrl512; // iOS only

  // Screenshots
  final List<String>
  screenshots; // screenshotUrls for iOS, screenshots for Android
  final List<String> ipadScreenshots; // iOS only
  final List<String> appletvScreenshots; // iOS only

  // Categories & Genres
  final String? category; // primaryGenreName for iOS, category for Android
  final int? primaryGenreId; // iOS only
  final List<String> genres; // iOS only
  final List<String> genreIds; // iOS only

  // Content Rating
  final String?
  contentRating; // trackContentRating for iOS, contentRating for Android
  final String? contentAdvisoryRating; // iOS only
  final List<String> advisories; // iOS only

  // Version & Technical Information
  final String? version;
  final String? minimumOsVersion; // iOS only
  final String?
  fileSizeBytes; // iOS fileSizeBytes, Android can extract if available
  final List<String> supportedDevices; // iOS only
  final List<String> features; // iOS only
  final List<String> languageCodes; // languageCodesISO2A for iOS

  // Release Dates
  final String? releaseDate; // original release date
  final String? currentVersionReleaseDate; // iOS only
  final String? lastUpdated; // for Android compatibility

  // URLs & Links
  final String? downloadUrl; // trackViewUrl for iOS, Play Store URL for Android

  // Gaming Features
  final bool? isGameCenterEnabled; // iOS only

  // Enterprise Features
  final bool? isVppDeviceBasedLicensingEnabled; // iOS only

  // Android-specific fields
  final int? downloads; // Android only

  // Additional platform-specific data
  final Map<String, dynamic>? additionalInfo;

  AppInfo({
    // Core Identity Fields
    required this.id,
    required this.name,
    required this.developer,
    this.trackCensoredName,
    this.bundleId,
    this.kind,
    this.wrapperType,

    // Developer/Publisher Information
    this.artistId,
    this.artistViewUrl,
    this.sellerName,
    this.sellerUrl,

    // App Description & Content
    this.description,
    this.summary,
    this.releaseNotes,

    // Ratings & Reviews
    this.rating,
    this.ratingCount,
    this.currentVersionRating,
    this.currentVersionRatingCount,

    // Pricing Information
    this.price,
    this.priceAmount,
    this.currency,

    // App Icons & Artwork
    this.iconUrl,
    this.artworkUrl60,
    this.artworkUrl100,
    this.artworkUrl512,

    // Screenshots
    List<String>? screenshots,
    List<String>? ipadScreenshots,
    List<String>? appletvScreenshots,

    // Categories & Genres
    this.category,
    this.primaryGenreId,
    List<String>? genres,
    List<String>? genreIds,

    // Content Rating
    this.contentRating,
    this.contentAdvisoryRating,
    List<String>? advisories,

    // Version & Technical Information
    this.version,
    this.minimumOsVersion,
    this.fileSizeBytes,
    List<String>? supportedDevices,
    List<String>? features,
    List<String>? languageCodes,

    // Release Dates
    this.releaseDate,
    this.currentVersionReleaseDate,
    this.lastUpdated,

    // URLs & Links
    this.downloadUrl,

    // Gaming Features
    this.isGameCenterEnabled,

    // Enterprise Features
    this.isVppDeviceBasedLicensingEnabled,

    // Android-specific fields
    this.downloads,

    // Additional platform-specific data
    this.additionalInfo,
  }) : screenshots = screenshots ?? [],
       ipadScreenshots = ipadScreenshots ?? [],
       appletvScreenshots = appletvScreenshots ?? [],
       genres = genres ?? [],
       genreIds = genreIds ?? [],
       advisories = advisories ?? [],
       supportedDevices = supportedDevices ?? [],
       features = features ?? [],
       languageCodes = languageCodes ?? [];

  /// Factory constructor for creating from iTunes/App Store JSON data
  factory AppInfo.fromItunesJson(Map<String, dynamic> json) {
    // Extract screenshots
    final screenshotUrls =
        (json['screenshotUrls'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final ipadScreenshotUrls =
        (json['ipadScreenshotUrls'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final appletvScreenshotUrls =
        (json['appletvScreenshotUrls'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    // Extract genres
    final genresList =
        (json['genres'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
        [];
    final genreIdsList =
        (json['genreIds'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    // Extract supported devices, features, languages
    final supportedDevicesList =
        (json['supportedDevices'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final featuresList =
        (json['features'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final languageCodesList =
        (json['languageCodesISO2A'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final advisoriesList =
        (json['advisories'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    return AppInfo(
      // Core Identity
      id: json['trackId']?.toString() ?? '',
      name: json['trackName']?.toString() ?? 'Unknown App',
      developer: json['artistName']?.toString() ?? 'Unknown Developer',
      trackCensoredName: json['trackCensoredName']?.toString(),
      bundleId: json['bundleId']?.toString(),
      kind: json['kind']?.toString(),
      wrapperType: json['wrapperType']?.toString(),

      // Developer/Publisher Information
      artistId: json['artistId'] as int?,
      artistViewUrl: json['artistViewUrl']?.toString(),
      sellerName: json['sellerName']?.toString(),
      sellerUrl: json['sellerUrl']?.toString(),

      // App Description & Content
      description: json['description']?.toString(),
      summary: json['releaseNotes']?.toString(), // iOS release notes as summary
      releaseNotes: json['releaseNotes']?.toString(),

      // Ratings & Reviews
      rating: (json['averageUserRating'] as num?)?.toDouble(),
      ratingCount: json['userRatingCount'] as int?,
      currentVersionRating: (json['averageUserRatingForCurrentVersion'] as num?)
          ?.toDouble(),
      currentVersionRatingCount:
          json['userRatingCountForCurrentVersion'] as int?,

      // Pricing Information
      price:
          json['formattedPrice']?.toString() ??
          'Free', // Default to 'Free' if not specified
      priceAmount: (json['price'] as num?)?.toDouble(),
      currency: json['currency']?.toString(),

      // App Icons & Artwork
      iconUrl:
          json['artworkUrl512']?.toString() ??
          json['artworkUrl100']?.toString(),
      artworkUrl60: json['artworkUrl60']?.toString(),
      artworkUrl100: json['artworkUrl100']?.toString(),
      artworkUrl512: json['artworkUrl512']?.toString(),

      // Screenshots - combine all screenshot types for backward compatibility
      screenshots: [
        ...screenshotUrls,
        ...ipadScreenshotUrls,
        ...appletvScreenshotUrls,
      ],
      ipadScreenshots: ipadScreenshotUrls,
      appletvScreenshots: appletvScreenshotUrls,

      // Categories & Genres
      category: json['primaryGenreName']?.toString(),
      primaryGenreId: json['primaryGenreId'] as int?,
      genres: genresList,
      genreIds: genreIdsList,

      // Content Rating
      contentRating: json['trackContentRating']?.toString(),
      contentAdvisoryRating: json['contentAdvisoryRating']?.toString(),
      advisories: advisoriesList,

      // Version & Technical Information
      version: json['version']?.toString(),
      minimumOsVersion: json['minimumOsVersion']?.toString(),
      fileSizeBytes: json['fileSizeBytes']?.toString(),
      supportedDevices: supportedDevicesList,
      features: featuresList,
      languageCodes: languageCodesList,

      // Release Dates
      releaseDate: json['releaseDate']?.toString(),
      currentVersionReleaseDate: json['currentVersionReleaseDate']?.toString(),
      lastUpdated: json['currentVersionReleaseDate']
          ?.toString(), // For compatibility
      // URLs & Links
      downloadUrl: json['trackViewUrl']?.toString(),

      // Gaming Features
      isGameCenterEnabled: json['isGameCenterEnabled'] as bool?,

      // Enterprise Features
      isVppDeviceBasedLicensingEnabled:
          json['isVppDeviceBasedLicensingEnabled'] as bool?,

      // Additional platform-specific data (for backward compatibility)
      additionalInfo: {
        if (json['fileSizeBytes'] != null) 'fileSize': json['fileSizeBytes'],
        if (json['minimumOsVersion'] != null)
          'minimumOsVersion': json['minimumOsVersion'],
        if (json['supportedDevices'] != null)
          'supportedDevices': json['supportedDevices'],
        if (json['languageCodesISO2A'] != null)
          'languageCodesISO2A': json['languageCodesISO2A'],
      },
    );
  }

  @override
  String toString() {
    return 'AppInfo(id: $id, name: $name, developer: $developer, rating: $rating)';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    developer,
    bundleId,
    version,
    rating,
    ratingCount,
  ];
}
