# App Store Metadata

[![pub package](https://img.shields.io/pub/v/app_store_metadata.svg)](https://pub.dev/packages/app_store_metadata)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Dart SDK for fetching app metadata from Google Play Store and Apple App Store. This package provides a unified interface to retrieve comprehensive app information including ratings, descriptions, screenshots, pricing, and more.

## Features

- ✅ **Google Play Store** metadata fetching
- ✅ **Apple App Store** metadata fetching and search
- ✅ **Unified API** for both platforms
- ✅ **Rich metadata** including ratings, screenshots, pricing
- ✅ **Country/language support** for localized data
- ✅ **Type-safe** Dart models
- ✅ **Error handling** with custom exceptions
- ✅ **Well documented** and tested

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  app_store_metadata: ^1.0.0
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

  // Fetch app from Apple App Store
  final iosApp = await client.getAppleAppStoreInfo(
    bundleId: 'net.whatsapp.WhatsApp'
  );
  print('${iosApp.name} - Version: ${iosApp.version}');
}
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

### AppInfo Model

The data model representing app metadata:

```dart
class AppInfo {
  final String id;              // App identifier
  final String name;            // App name
  final String developer;       // Developer name
  final String? description;    // Full description
  final String? summary;        // Short description
  final double? rating;         // Average rating (0.0-5.0)
  final int? ratingCount;       // Number of ratings
  final String? price;          // Price (e.g., "Free", "$2.99")
  final String? currency;       // Currency code
  final String? iconUrl;        // App icon URL
  final List<String> screenshots; // Screenshot URLs
  final String? category;       // App category
  final String? contentRating;  // Content rating
  final String? version;        // Current version
  final String? lastUpdated;    // Last update date
  final String? downloadUrl;    // Download/store URL
  final int? downloads;         // Download count
  final String? bundleId;       // Bundle identifier
  final Map<String, dynamic>? additionalInfo; // Extra data
}
```

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
