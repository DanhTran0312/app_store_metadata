import 'dart:convert';

import 'package:http/http.dart' as http;

import '../exceptions/app_store_exceptions.dart';
import '../models/app_info.dart';

/// Client for fetching app metadata from Apple App Store
class AppleAppStore {
  static const String _lookupUrl = 'https://itunes.apple.com/lookup';
  static const String _searchUrl = 'https://itunes.apple.com/search';
  final http.Client _httpClient;

  AppleAppStore({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  /// Fetch app information from Apple App Store
  ///
  /// Either [appId] or [bundleId] must be provided.
  /// [appId] The Apple app ID (numeric ID)
  /// [bundleId] The app's bundle ID (e.g., 'com.whatsapp.WhatsApp')
  /// [country] Optional country code (e.g., 'US', 'GB')
  Future<AppInfo> getAppInfo({
    String? appId,
    String? bundleId,
    String country = 'US',
  }) async {
    if (appId == null && bundleId == null) {
      throw AppStoreException('Either appId or bundleId must be provided');
    }

    try {
      // If we have appId, use it directly
      if (appId != null) {
        final lookupUrl = '$_lookupUrl?id=$appId&country=$country';
        final response = await _httpClient.get(Uri.parse(lookupUrl));

        if (response.statusCode != 200) {
          throw AppStoreException(
            'Failed to fetch app info (Status: ${response.statusCode})',
          );
        }

        final data = json.decode(response.body);
        final results = data['results'] as List;

        if (results.isEmpty) {
          throw AppNotFoundException('App not found: $appId');
        }

        return _parseAppStoreJson(results.first);
      }

      // If we only have bundleId, try to find the app
      if (bundleId != null) {
        // First try direct lookup
        final lookupUrl = '$_lookupUrl?bundleId=$bundleId&country=$country';
        final response = await _httpClient.get(Uri.parse(lookupUrl));

        if (response.statusCode != 200) {
          throw AppStoreException(
            'Lookup failed (Status: ${response.statusCode})',
          );
        }

        final data = json.decode(response.body);
        final results = data['results'] as List;

        if (results.isNotEmpty) {
          return _parseAppStoreJson(results.first);
        }

        // If direct lookup fails, try searching
        final searchUrl =
            '$_searchUrl?term=$bundleId&country=$country&entity=software';
        final searchResponse = await _httpClient.get(Uri.parse(searchUrl));

        if (searchResponse.statusCode != 200) {
          throw AppStoreException(
            'Search failed (Status: ${searchResponse.statusCode})',
          );
        }

        final searchData = json.decode(searchResponse.body);
        final searchResults = searchData['results'] as List;

        // Look for exact bundle ID match
        for (final result in searchResults) {
          if (result['bundleId'] == bundleId) {
            return _parseAppStoreJson(result);
          }
        }

        throw AppNotFoundException('App not found with bundle ID: $bundleId');
      }

      // This should never happen due to the initial check
      throw AppStoreException(
        'Invalid state: neither appId nor bundleId provided',
      );
    } catch (e) {
      if (e is AppStoreException) rethrow;
      throw AppStoreException('Failed to fetch app info: $e');
    }
  }

  /// Search for apps in Apple App Store
  Future<List<AppInfo>> searchApps(
    String query, {
    String country = 'US',
    int limit = 10,
  }) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        '$_searchUrl?term=$encodedQuery&country=$country&limit=$limit&entity=software';

    try {
      final response = await _httpClient.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw AppStoreException(
          'Search failed (Status: ${response.statusCode})',
        );
      }

      final data = json.decode(response.body);
      final results = data['results'] as List;

      return results.map((json) => _parseAppStoreJson(json)).toList();
    } catch (e) {
      if (e is AppStoreException) rethrow;
      throw AppStoreException('Search failed: $e');
    }
  }

  /// Parse JSON response from Apple App Store
  AppInfo _parseAppStoreJson(Map<String, dynamic> json) {
    // Extract screenshots
    final screenshots = <String>[];
    if (json['screenshotUrls'] != null) {
      screenshots.addAll((json['screenshotUrls'] as List).cast<String>());
    }
    if (json['ipadScreenshotUrls'] != null) {
      screenshots.addAll((json['ipadScreenshotUrls'] as List).cast<String>());
    }

    return AppInfo(
      id: json['trackId'].toString(),
      name: json['trackName'] ?? 'Unknown App',
      developer: json['artistName'] ?? 'Unknown Developer',
      description: json['description'],
      summary: json['releaseNotes'],
      rating: (json['averageUserRating'] as num?)?.toDouble(),
      ratingCount: json['userRatingCount'] as int?,
      price: json['formattedPrice'] ?? 'Free',
      currency: json['currency'],
      iconUrl: json['artworkUrl512'] ?? json['artworkUrl100'],
      screenshots: screenshots,
      category: json['primaryGenreName'],
      contentRating: json['trackContentRating'],
      version: json['version'],
      lastUpdated: json['currentVersionReleaseDate'],
      downloadUrl: json['trackViewUrl'],
      bundleId: json['bundleId'],
      additionalInfo: {
        'fileSize': json['fileSizeBytes'],
        'minimumOsVersion': json['minimumOsVersion'],
        'supportedDevices': json['supportedDevices'],
        'languageCodesISO2A': json['languageCodesISO2A'],
      },
    );
  }

  void dispose() {
    _httpClient.close();
  }
}
