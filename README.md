# App Store Metadata

[![pub package](https://img.shields.io/pub/v/app_store_metadata.svg)](https://pub.dev/packages/app_store_metadata)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive Dart SDK for fetching rich app metadata from Google Play Store and Apple App Store. This package provides a unified interface to retrieve detailed app information including ratings, descriptions, multiple screenshot types, artwork, technical specifications, and much more.

## Features

- ✅ **Google Play Store** metadata fetching
- ✅ **Apple App Store** metadata fetching and search with **complete iTunes API coverage**
- ✅ **Batch processing** for fetching multiple apps efficiently
- ✅ **Unified API** for both platforms with **100% backward compatibility**
- ✅ **Enhanced metadata** including multiple screenshot types, artwork sizes, detailed ratings
- ✅ **Rich iTunes support** with file sizes, supported devices, languages, genres, and more
- ✅ **dart_mappable integration** for efficient serialization/deserialization
- ✅ **Multiple artwork sizes** (60x60, 100x100, 512x512)
- ✅ **Detailed ratings** (overall + current version ratings)
- ✅ **Technical specifications** (file size, minimum OS, supported devices)
- ✅ **Gaming features** (Game Center support detection)
- ✅ **Enterprise features** (VPP device-based licensing)
- ✅ **Country/language support** for localized data
- ✅ **Type-safe** Dart models with generated code
- ✅ **Error handling** with custom exceptions
- ✅ **Comprehensive testing** with real API verification

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  app_store_metadata: ^2.1.0
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:app_store_metadata/app_store_metadata.dart';

void main() async {
  final client = AppStoreClient();

  // Fetch app from Google Play Store
  final androidApp = await client.getGooglePlayAppInfo('com.whatsapp');
  print('${androidApp.name} - Rating: ${androidApp.rating}');
  print('Screenshots: ${androidApp.screenshots.length}');

  // Fetch app from Apple App Store with rich metadata
  final iosApp = await client.getAppleAppStoreInfo(
    bundleId: 'com.google.Drive'
  );
  print('${iosApp.name} - Version: ${iosApp.version}');
  print('File Size: ${iosApp.fileSizeBytes} bytes');
  print('Screenshots: ${iosApp.screenshots.length}');
  print('iPad Screenshots: ${iosApp.ipadScreenshots.length}');
  print('Supported Languages: ${iosApp.languageCodes.length}');
  print('Game Center: ${iosApp.isGameCenterEnabled}');
}
```

## 🚀 Batch Processing

Efficiently fetch metadata for multiple apps at once:

```dart
import 'package:app_store_metadata/app_store_metadata.dart';

void main() async {
  final client = AppStoreClient();

  // Fetch multiple Google Play Store apps
  final googlePlayApps = await client.getMultipleGooglePlayAppInfo([
    'com.whatsapp',
    'com.facebook.katana',
    'com.instagram.android',
  ]);

  // Results are returned as a Map<String, AppInfo>
  for (final entry in googlePlayApps.entries) {
    print('${entry.key}: ${entry.value.name} - ${entry.value.rating}★');
  }

  // Fetch multiple Apple App Store apps
  final appleApps = await client.getMultipleAppleAppStoreInfo([
    '310633997', // WhatsApp
    '284882215', // Facebook
    '389801252', // Instagram
  ]);

  // Process results
  for (final entry in appleApps.entries) {
    final app = entry.value;
    print('${app.name}: ${app.version} (${app.fileSizeBytes} bytes)');
  }
}
```

### Batch Processing Benefits

- **Efficient**: Apple App Store batch requests use the native iTunes API (up to 200 apps per request)
- **Concurrent**: Google Play Store requests are made concurrently for optimal performance  
- **Resilient**: Failed individual app lookups don't affect successful ones
- **Flexible**: Mix and match different app stores and regions

## 🚀 What's New in v2.0

### Enhanced iTunes/App Store Support
The AppInfo model now includes **comprehensive iTunes API coverage**:

```dart
final app = await client.getAppleAppStoreInfo(appId: '507874739');

// Multiple screenshot types
print('iPhone Screenshots: ${app.screenshots.length}');
print('iPad Screenshots: ${app.ipadScreenshots.length}');
print('Apple TV Screenshots: ${app.appletvScreenshots.length}');

// Multiple artwork sizes
print('Icon 60x60: ${app.artworkUrl60}');
print('Icon 512x512: ${app.artworkUrl512}');

// Detailed ratings
print('Overall Rating: ${app.rating} (${app.ratingCount} reviews)');
print('Current Version Rating: ${app.currentVersionRating}');

// Rich metadata
print('File Size: ${app.fileSizeBytes} bytes');
print('Minimum iOS: ${app.minimumOsVersion}');
print('Supported Languages: ${app.languageCodes.join(', ')}');
print('Genres: ${app.genres.join(', ')}');
print('Game Center Enabled: ${app.isGameCenterEnabled}');
```

### Direct iTunes JSON Support
Use the new factory constructor for direct iTunes API integration:

```dart
// If you're working directly with iTunes API responses
final itunesResponse = await http.get(Uri.parse('https://itunes.apple.com/lookup?id=507874739'));
final data = json.decode(itunesResponse.body);
final appInfo = AppInfo.fromItunesJson(data['results'][0]);

// All iTunes fields are now directly accessible
print('Supported Devices: ${appInfo.supportedDevices.join(', ')}');
print('VPP Licensed: ${appInfo.isVppDeviceBasedLicensingEnabled}');
```

## Usage

### Google Play Store

Fetch app metadata using the Android package ID:

```dart
final client = AppStoreClient();

// Basic usage
final app = await client.getGooglePlayAppInfo('com.example.app');

// With country and language specification
final localizedApp = await client.getGooglePlayAppInfo(
  'com.example.app',
  country: 'GB',  // United Kingdom
  language: 'en', // English
);

print('App: ${app.name}');
print('Developer: ${app.developer}');
print('Rating: ${app.rating}/5.0 (${app.ratingCount} reviews)');
print('Price: ${app.price} ${app.currency}');
print('Category: ${app.category}');
```

### Apple App Store

Fetch app metadata using either app ID or bundle ID:

```dart
final client = AppStoreClient();

// Using bundle ID (recommended)
final app = await client.getAppleAppStoreInfo(
  bundleId: 'com.example.app',
  country: 'US',
);

// Using app ID
final appById = await client.getAppleAppStoreInfo(
  appId: '123456789',
  country: 'US',
);

print('App: ${app.name}');
print('Version: ${app.version}');
print('Last Updated: ${app.lastUpdated}');
print('Content Rating: ${app.contentRating}');
```

### Apple App Store Search

Search for apps in the Apple App Store:

```dart
final client = AppStoreClient();

final searchResults = await client.searchAppleAppStore(
  'social media',
  country: 'US',
  limit: 10,
);

for (final app in searchResults) {
  print('${app.name} by ${app.developer} - ${app.rating}⭐');
}
```

## API Reference

### AppStoreClient

The main client class for interacting with app stores.

#### Methods

##### `getGooglePlayAppInfo(String packageId, {String country, String language})`

Fetches app metadata from Google Play Store.

- **packageId**: Android package ID (e.g., `'com.whatsapp'`)
- **country**: Country code (default: `'US'`)
- **language**: Language code (default: `'en'`)
- **Returns**: `Future<AppInfo>`

##### `getAppleAppStoreInfo({String? appId, String? bundleId, String country})`

Fetches app metadata from Apple App Store.

- **appId**: Apple app ID (numeric)
- **bundleId**: App bundle ID (e.g., `'com.example.app'`)
- **country**: Country code (default: `'US'`)
- **Returns**: `Future<AppInfo>`

*Note: Either `appId` or `bundleId` must be provided.*

##### `searchAppleAppStore(String query, {String country, int limit})`

Searches for apps in Apple App Store.

- **query**: Search query
- **country**: Country code (default: `'US'`)
- **limit**: Maximum results (default: `10`)
- **Returns**: `Future<List<AppInfo>>`

##### `getMultipleGooglePlayAppInfo(List<String> packageIds, {String country, String language})`

Fetches app metadata for multiple Google Play Store apps.

- **packageIds**: List of Android package IDs (e.g., `['com.whatsapp', 'com.facebook.katana']`)
- **country**: Country code (default: `'US'`)
- **language**: Language code (default: `'en'`)
- **Returns**: `Future<Map<String, AppInfo>>` - Map where keys are package IDs and values are AppInfo objects

##### `getMultipleAppleAppStoreInfo(List<String> appIds, {String country})`

Fetches app metadata for multiple Apple App Store apps.

- **appIds**: List of Apple app IDs (e.g., `['310633997', '284882215']`)
- **country**: Country code (default: `'US'`)
- **Returns**: `Future<Map<String, AppInfo>>` - Map where keys are app IDs and values are AppInfo objects

*Note: Failed lookups will not be included in the result map for both batch methods.*

### Enhanced AppInfo Model

The comprehensive data model representing rich app metadata with full iTunes API support:

```dart
class AppInfo {
  // Core Identity Fields
  final String id;              // App identifier (trackId for iOS, packageId for Android)
  final String name;            // App name
  final String? trackCensoredName; // iOS censored name
  final String? bundleId;       // Bundle identifier
  final String? kind;           // iOS app type (e.g., "software")
  
  // Developer/Publisher Information  
  final String developer;       // Developer name
  final int? artistId;          // iOS artist ID
  final String? artistViewUrl;  // iOS artist page URL
  final String? sellerName;     // iOS seller name
  final String? sellerUrl;      // iOS seller URL
  
  // App Description & Content
  final String? description;    // Full description
  final String? summary;        // Short description/release notes
  final String? releaseNotes;   // iOS release notes
  
  // Ratings & Reviews (Enhanced)
  final double? rating;         // Average rating (0.0-5.0)
  final int? ratingCount;       // Number of ratings
  final double? currentVersionRating;     // iOS current version rating
  final int? currentVersionRatingCount;   // iOS current version rating count
  
  // Pricing Information
  final String? price;          // Price (e.g., "Free", "$2.99")
  final double? priceAmount;    // Actual price value
  final String? currency;       // Currency code
  
  // App Icons & Artwork (Multiple Sizes)
  final String? iconUrl;        // Primary app icon URL
  final String? artworkUrl60;   // iOS 60x60 icon
  final String? artworkUrl100;  // iOS 100x100 icon  
  final String? artworkUrl512;  // iOS 512x512 icon
  
  // Screenshots (Multiple Types)
  final List<String> screenshots;      // Combined screenshots for compatibility
  final List<String> ipadScreenshots;  // iOS iPad screenshots
  final List<String> appletvScreenshots; // iOS Apple TV screenshots
  
  // Categories & Genres (Enhanced)
  final String? category;       // Primary app category
  final int? primaryGenreId;    // iOS primary genre ID
  final List<String> genres;    // iOS genre names
  final List<String> genreIds;  // iOS genre IDs
  
  // Content Rating (Enhanced)
  final String? contentRating;  // Content rating
  final String? contentAdvisoryRating; // iOS advisory rating
  final List<String> advisories; // iOS content advisories
  
  // Version & Technical Information
  final String? version;        // Current version
  final String? minimumOsVersion; // iOS minimum OS version
  final String? fileSizeBytes;  // iOS file size in bytes
  final List<String> supportedDevices; // iOS supported devices
  final List<String> features;  // iOS features (e.g., "iosUniversal")
  final List<String> languageCodes; // iOS supported language codes
  
  // Release Dates  
  final String? releaseDate;    // Original release date
  final String? currentVersionReleaseDate; // iOS current version release date
  final String? lastUpdated;    // Last update date (compatibility)
  
  // URLs & Links
  final String? downloadUrl;    // Download/store URL
  
  // Gaming Features
  final bool? isGameCenterEnabled; // iOS Game Center support
  
  // Enterprise Features  
  final bool? isVppDeviceBasedLicensingEnabled; // iOS VPP licensing
  
  // Android-specific fields
  final int? downloads;         // Android download count
  
  // Additional platform-specific data (Backward compatibility)
  final Map<String, dynamic>? additionalInfo; // Extra data
}
```

### 🔄 Backward Compatibility

**All existing code continues to work without changes!** The model has been enhanced while maintaining full backward compatibility:

- All original fields remain accessible
- `screenshots` field combines all screenshot types for compatibility  
- `additionalInfo` is still populated with technical data
- Existing APIs (`getGooglePlayAppInfo`, `getAppleAppStoreInfo`) work unchanged

### Error Handling

The package throws `AppStoreException` for various error conditions:

```dart
try {
  final app = await client.getGooglePlayAppInfo('invalid.package.id');
} on AppStoreException catch (e) {
  print('App store error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## Country Codes

Use ISO 3166-1 alpha-2 country codes:

- `US` - United States
- `GB` - United Kingdom
- `CA` - Canada
- `AU` - Australia
- `DE` - Germany
- `FR` - France
- `JP` - Japan
- And more...

## Language Codes

Use ISO 639-1 language codes for Google Play Store:

- `en` - English
- `es` - Spanish
- `fr` - French
- `de` - German
- `ja` - Japanese
- And more...

## 🔧 Migration from v1.x to v2.0

**Good news: No breaking changes!** Your existing code will work without any modifications.

### What Works Unchanged
```dart
// ✅ All v1.x code continues to work
final app = await client.getAppleAppStoreInfo(bundleId: 'com.example.app');
print(app.name);           // ✅ Still works
print(app.screenshots);    // ✅ Still works (combines all screenshot types)
print(app.rating);         // ✅ Still works  
print(app.additionalInfo); // ✅ Still works (populated with technical data)
```

### What's New and Available
```dart
// 🆕 New fields you can now access
final app = await client.getAppleAppStoreInfo(bundleId: 'com.example.app');

// Enhanced screenshots
print(app.ipadScreenshots);    // 🆕 iPad-specific screenshots
print(app.appletvScreenshots); // 🆕 Apple TV screenshots  

// Multiple artwork sizes
print(app.artworkUrl512);      // 🆕 High-resolution icon
print(app.artworkUrl60);       // 🆕 Small icon

// Detailed ratings
print(app.currentVersionRating); // 🆕 Current version rating

// Rich technical data  
print(app.fileSizeBytes);      // 🆕 File size
print(app.minimumOsVersion);   // 🆕 Minimum OS
print(app.supportedDevices);   // 🆕 Supported devices
print(app.languageCodes);      // 🆕 Supported languages

// Gaming & enterprise features
print(app.isGameCenterEnabled); // 🆕 Game Center support
print(app.isVppDeviceBasedLicensingEnabled); // 🆕 Enterprise licensing
```

### Direct iTunes API Integration
```dart
// 🆕 New factory constructor for direct iTunes data
final itunesData = {'trackId': 123, 'trackName': 'My App', ...};
final app = AppInfo.fromItunesJson(itunesData);
```

## Examples

Check out the [example](example/main.dart) directory for a complete working example.

## Testing

Run the test suite:

```bash
dart test
```

Generate coverage report:

```bash
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes.

## Support

If you encounter any issues or have questions, please [file an issue](https://github.com/DanhTran0312/app_store_metadata/issues) on GitHub.
