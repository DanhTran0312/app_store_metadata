import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

import '../exceptions/app_store_exceptions.dart';
import '../models/app_info.dart';

/// Client for fetching app metadata from Google Play Store
class GooglePlayStore {
  static const String _baseUrl = 'https://play.google.com';
  final http.Client _httpClient;

  GooglePlayStore({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  /// Fetch app information from Google Play Store
  Future<AppInfo> getAppInfo(
    String packageId, {
    String country = 'US',
    String language = 'en',
  }) async {
    final url =
        '$_baseUrl/store/apps/details?id=$packageId&gl=$country&hl=$language';

    try {
      final response = await _httpClient.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw AppNotFoundException(
          'App not found: $packageId (Status: ${response.statusCode})',
        );
      }

      return _parsePlayStoreHtml(response.body, packageId);
    } catch (e) {
      if (e is AppStoreException) rethrow;
      throw AppStoreException('Failed to fetch app info: $e');
    }
  }

  /// Parse HTML response from Google Play Store
  AppInfo _parsePlayStoreHtml(String html, String packageId) {
    final document = html_parser.parse(html);

    // Extract app name
    String? name;
    // Try different selectors for app name
    final selectors = [
      'h1[itemprop="name"] span',
      'h1[itemprop="name"]',
      'h1.title',
      'h1',
      'div[itemprop="name"]',
    ];

    for (final selector in selectors) {
      final element = document.querySelector(selector);
      if (element != null && element.text.trim().isNotEmpty) {
        name = element.text.trim();
        break;
      }
    }

    // If still not found, try finding any element containing the app name
    if (name == null) {
      final elements = document.querySelectorAll('*');
      for (final element in elements) {
        if (element.text.trim().isNotEmpty &&
            !element.text.contains('WhatsApp LLC') &&
            element.text.length < 50) {
          // Reasonable length for app name
          name = element.text.trim();
          break;
        }
      }
    }

    final finalName = name ?? 'Unknown App';

    // Extract developer
    final developerElement = document.querySelector(
      'a[href*="/store/apps/developer"]',
    );
    final developer = developerElement?.text.trim() ?? 'Unknown Developer';

    // Extract rating
    final ratingElement = document.querySelector('div[aria-label*="Rated"]');
    double? rating;
    if (ratingElement != null) {
      final ratingText = ratingElement.attributes['aria-label'] ?? '';
      final ratingMatch = RegExp(
        r'Rated (\d+\.?\d*) stars',
      ).firstMatch(ratingText);
      if (ratingMatch != null) {
        rating = double.tryParse(ratingMatch.group(1) ?? '');
      }
    }

    // Extract description
    final descriptionElement = document.querySelector(
      'div[itemprop="description"]',
    );
    final description = descriptionElement?.text.trim();

    // Extract icon URL
    final iconElement = document.querySelector('img[alt="Icon image"]');
    final iconUrl = iconElement?.attributes['src'];

    // Extract screenshots
    final screenshots = <String>[];
    final screenshotElements = document.querySelectorAll(
      'img[data-screenshot-index]',
    );
    for (final element in screenshotElements) {
      final src = element.attributes['src'];
      if (src != null) screenshots.add(src);
    }

    // Extract category
    final categoryElement = document.querySelector('a[itemprop="genre"]');
    final category = categoryElement?.text.trim();

    // Extract version
    String? version;
    final versionElements = document.querySelectorAll('div');
    for (final element in versionElements) {
      if (element.text.contains('Version')) {
        final versionMatch = RegExp(
          r'Version\s+(\S+)',
        ).firstMatch(element.text);
        if (versionMatch != null) {
          version = versionMatch.group(1);
          break;
        }
      }
    }

    // Extract price
    final priceElement = document.querySelector('span[aria-label*="Buy"]');
    final price = priceElement?.text.trim() ?? 'Free';

    return AppInfo(
      id: packageId,
      name: finalName,
      developer: developer,
      description: description,
      rating: rating,
      iconUrl: iconUrl,
      screenshots: screenshots,
      category: category,
      version: version,
      price: price,
      downloadUrl: '$_baseUrl/store/apps/details?id=$packageId',
    );
  }

  void dispose() {
    _httpClient.close();
  }
}
