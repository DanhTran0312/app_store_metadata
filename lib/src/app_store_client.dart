import 'dart:async';

import 'exceptions/app_store_exceptions.dart';
import 'models/app_info.dart';
import 'stores/apple_app_store.dart';
import 'stores/google_play_store.dart';

/// Main client for fetching app metadata from various app stores
class AppStoreClient {
  final GooglePlayStore _googlePlayStore;
  final AppleAppStore _appleAppStore;

  AppStoreClient({
    GooglePlayStore? googlePlayStore,
    AppleAppStore? appleAppStore,
  }) : _googlePlayStore = googlePlayStore ?? GooglePlayStore(),
       _appleAppStore = appleAppStore ?? AppleAppStore();

  /// Fetch app info from Google Play Store
  ///
  /// [packageId] The Android package ID (e.g., 'com.example.app')
  /// [country] Optional country code (e.g., 'US', 'GB')
  /// [language] Optional language code (e.g., 'en', 'es')
  Future<AppInfo> getGooglePlayAppInfo(
    String packageId, {
    String country = 'US',
    String language = 'en',
  }) async {
    try {
      return await _googlePlayStore.getAppInfo(
        packageId,
        country: country,
        language: language,
      );
    } catch (e) {
      throw AppStoreException('Failed to fetch Google Play app info: $e');
    }
  }

  /// Fetch app info from Apple App Store
  ///
  /// Either [appId] or [bundleId] must be provided.
  /// [appId] The Apple app ID (numeric ID)
  /// [bundleId] The app's bundle ID (e.g., 'com.whatsapp.WhatsApp')
  /// [country] Optional country code (e.g., 'US', 'GB')
  Future<AppInfo> getAppleAppStoreInfo({
    String? appId,
    String? bundleId,
    String country = 'US',
  }) async {
    try {
      return await _appleAppStore.getAppInfo(
        appId: appId,
        bundleId: bundleId,
        country: country,
      );
    } catch (e) {
      throw AppStoreException('Failed to fetch Apple App Store info: $e');
    }
  }

  /// Search for apps in Apple App Store
  ///
  /// [query] Search query
  /// [country] Optional country code
  /// [limit] Maximum number of results (default: 10)
  Future<List<AppInfo>> searchAppleAppStore(
    String query, {
    String country = 'US',
    int limit = 10,
  }) async {
    try {
      return await _appleAppStore.searchApps(
        query,
        country: country,
        limit: limit,
      );
    } catch (e) {
      throw AppStoreException('Failed to search Apple App Store: $e');
    }
  }

  /// Fetch app info for multiple Google Play Store apps
  ///
  /// [packageIds] List of Android package IDs (e.g., ['com.whatsapp', 'com.example.app'])
  /// [country] Optional country code (e.g., 'US', 'GB')
  /// [language] Optional language code (e.g., 'en', 'es')
  /// Returns a map where keys are the requested package IDs and values are AppInfo objects.
  /// Failed lookups will not be included in the result map.
  Future<Map<String, AppInfo>> getMultipleGooglePlayAppInfo(
    List<String> packageIds, {
    String country = 'US',
    String language = 'en',
  }) async {
    try {
      return await _googlePlayStore.getMultipleAppInfo(
        packageIds,
        country: country,
        language: language,
      );
    } catch (e) {
      throw AppStoreException(
        'Failed to fetch multiple Google Play app info: $e',
      );
    }
  }

  /// Fetch app info for multiple Apple App Store apps
  ///
  /// [appIds] List of Apple app IDs (numeric IDs)
  /// [country] Optional country code (e.g., 'US', 'GB')
  /// Returns a map where keys are the requested app IDs and values are AppInfo objects.
  /// Failed lookups will not be included in the result map.
  Future<Map<String, AppInfo>> getMultipleAppleAppStoreInfo(
    List<String> appIds, {
    String country = 'US',
  }) async {
    try {
      return await _appleAppStore.getMultipleAppInfo(appIds, country: country);
    } catch (e) {
      throw AppStoreException(
        'Failed to fetch multiple Apple App Store info: $e',
      );
    }
  }
}
