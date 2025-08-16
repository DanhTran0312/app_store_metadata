# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2025-01-28

### Added
- **Batch Processing API**: New methods to efficiently fetch multiple apps at once
- `getMultipleGooglePlayAppInfo()`: Fetch multiple Google Play Store apps concurrently
- `getMultipleAppleAppStoreInfo()`: Fetch multiple Apple App Store apps using native iTunes batch API
- **Resilient Error Handling**: Failed individual lookups don't affect successful ones in batch requests
- **Comprehensive Testing**: Unit tests covering all batch processing scenarios

### Enhanced
- **Apple App Store Efficiency**: Leverages iTunes API's native support for up to 200 apps per request
- **Google Play Store Performance**: Concurrent HTTP requests for optimal throughput
- **Example Applications**: Updated examples to demonstrate batch processing capabilities
- **API Documentation**: Complete documentation for all new batch methods

### Technical
- **Return Type**: Batch methods return `Map<String, AppInfo>` for easy ID-to-result mapping
- **Backward Compatibility**: All existing APIs remain unchanged and fully supported
- **Error Resilience**: Batch operations continue processing even if individual apps fail
- **Performance Optimized**: Minimal overhead with efficient request batching strategies

## [2.0.0] - 2025-01-28

### Added
- **Enhanced AppInfo Model**: Comprehensive expansion to support all iTunes/App Store fields
- **Multiple Screenshot Types**: Separate fields for `screenshots`, `ipadScreenshots`, and `appletvScreenshots`
- **Multiple Artwork Sizes**: Support for `artworkUrl60`, `artworkUrl100`, and `artworkUrl512`
- **Detailed Rating Information**: Separate overall and current version ratings with counts
- **Rich Developer Information**: Artist ID, view URL, seller name and URL
- **Comprehensive Technical Metadata**: File size, minimum OS version, supported devices, languages
- **Gaming Features**: Game Center support detection
- **Enterprise Features**: VPP device-based licensing support
- **Enhanced Genre Support**: Multiple genres and genre IDs
- **Content Advisory Information**: Detailed content ratings and advisories
- **Release Date Tracking**: Both original release date and current version release date
- **Factory Constructor**: `AppInfo.fromItunesJson()` for direct iTunes API data parsing

### Enhanced
- **dart_mappable Integration**: Full adoption of dart_mappable for efficient serialization/deserialization
- **Apple App Store Implementation**: Complete rewrite to utilize all available iTunes fields
- **Google Play Store Compatibility**: Updated to work seamlessly with expanded model
- **Backward Compatibility**: All existing APIs continue to work, `additionalInfo` still populated
- **Screenshot Handling**: Combined screenshots for backward compatibility while providing separate access

### Technical
- **Generated Code**: Automatic code generation via dart_mappable for better performance
- **Type Safety**: Enhanced type safety with proper null handling
- **Test Coverage**: All tests updated and passing with expanded model
- **Real API Testing**: Verified with live Apple App Store and Google Play Store APIs

### Migration Guide
- Existing code continues to work without changes
- New fields are available for enhanced metadata access
- Use `AppInfo.fromItunesJson()` for direct iTunes API integration
- Access specialized screenshot arrays via `ipadScreenshots` and `appletvScreenshots`
- Rich artwork available through `artworkUrl60`, `artworkUrl100`, `artworkUrl512`

## [1.0.0] - 2025-06-12

### Added
- Initial release of app_store_metadata package
- Support for fetching app metadata from Google Play Store
- Support for fetching app metadata from Apple App Store
- Support for searching apps in Apple App Store
- Comprehensive AppInfo model with all relevant app metadata
- Custom exception classes for better error handling
- Full test coverage with unit tests
- Example usage in example/main.dart
- Complete documentation and README

### Features
- Unified API for both Google Play Store and Apple App Store
- Country and language localization support
- Rich metadata including ratings, screenshots, pricing
- Type-safe Dart models
- HTTP client abstraction for testing
- Comprehensive error handling
