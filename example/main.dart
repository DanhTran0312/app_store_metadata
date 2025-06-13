import 'package:app_store_metadata/app_store_metadata.dart';

void main() async {
  final client = AppStoreClient();

  try {
    // Fetch Google Play Store app info
    print('Fetching WhatsApp info from Google Play Store...');
    final googlePlayApp = await client.getGooglePlayAppInfo(
      'com.whatsapp',
      country: 'US',
      language: 'en',
    );
    print('App: ${googlePlayApp.name}');
    print('Developer: ${googlePlayApp.developer}');
    print('Rating: ${googlePlayApp.rating}');
    print('---');

    // Fetch Apple App Store app info
    print('Fetching WhatsApp info from Apple App Store...');
    final appleApp = await client.getAppleAppStoreInfo(
      bundleId: 'net.whatsapp.WhatsApp',
      country: 'US',
    );
    print('App: ${appleApp.name}');
    print('Developer: ${appleApp.developer}');
    print('Rating: ${appleApp.rating}');
    print('Version: ${appleApp.version}');
    print('---');

    // Search Apple App Store
    print('Searching for "social media" apps...');
    final searchResults = await client.searchAppleAppStore(
      'social media',
      country: 'US',
      limit: 5,
    );

    for (final app in searchResults) {
      print('- ${app.name} by ${app.developer}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
