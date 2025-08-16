import 'dart:convert';

import 'package:app_store_metadata/app_store_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('AppStoreClient', () {
    late AppStoreClient client;

    setUp(() {
      client = AppStoreClient();
    });

    group('Apple App Store', () {
      test('should fetch app info by appId', () async {
        final mockResponse = {
          'resultCount': 1,
          'results': [
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'averageUserRating': 4.69032,
              'userRatingCount': 15936654,
              'formattedPrice': 'Free',
              'description': 'WhatsApp Messenger is a FREE messaging app',
              'version': '25.17.81',
              'bundleId': 'net.whatsapp.WhatsApp',
              'artworkUrl512': 'https://example.com/icon.png',
              'screenshotUrls': ['https://example.com/screenshot.png'],
              'primaryGenreName': 'Social Networking',
              'trackContentRating': '12+',
              'currentVersionReleaseDate': '2025-06-10T17:00:36Z',
              'trackViewUrl': 'https://apps.apple.com/app/id310633997',
              'currency': 'USD',
              'releaseNotes': 'Bug fixes and improvements',
              'fileSizeBytes': 257449984,
              'minimumOsVersion': '15.1',
              'supportedDevices': ['iPhone', 'iPad'],
              'languageCodesISO2A': ['EN', 'ES', 'FR'],
            },
          ],
        };

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('lookup?id=310633997'));
          return http.Response(json.encode(mockResponse), 200);
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        final appInfo = await testClient.getAppleAppStoreInfo(
          appId: '310633997',
        );

        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.developer, equals('WhatsApp Inc.'));
        expect(appInfo.rating, equals(4.69032));
        expect(appInfo.ratingCount, equals(15936654));
        expect(appInfo.price, equals('Free'));
        expect(appInfo.version, equals('25.17.81'));
        expect(appInfo.bundleId, equals('net.whatsapp.WhatsApp'));
        expect(appInfo.category, equals('Social Networking'));
        expect(appInfo.contentRating, equals('12+'));
        expect(appInfo.iconUrl, equals('https://example.com/icon.png'));
        expect(
          appInfo.screenshots,
          contains('https://example.com/screenshot.png'),
        );
      });

      test('should fetch app info by bundleId', () async {
        final mockSearchResponse = {
          'resultCount': 1,
          'results': [
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'bundleId': 'net.whatsapp.WhatsApp',
              'averageUserRating': 4.69032,
              'formattedPrice': 'Free',
              'version': '25.17.81',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          if (request.url.toString().contains('bundleId=')) {
            // Direct lookup fails
            return http.Response(
              json.encode({'resultCount': 0, 'results': []}),
              200,
            );
          } else if (request.url.toString().contains('search?term=')) {
            // Search succeeds
            return http.Response(json.encode(mockSearchResponse), 200);
          }
          return http.Response('Not found', 404);
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        final appInfo = await testClient.getAppleAppStoreInfo(
          bundleId: 'net.whatsapp.WhatsApp',
        );

        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.bundleId, equals('net.whatsapp.WhatsApp'));
      });

      test(
        'should throw exception when neither appId nor bundleId provided',
        () async {
          expect(
            () => client.getAppleAppStoreInfo(),
            throwsA(isA<AppStoreException>()),
          );
        },
      );

      test('should handle app not found error', () async {
        final mockClient = MockClient((request) async {
          return http.Response(
            json.encode({'resultCount': 0, 'results': []}),
            200,
          );
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        expect(
          () => testClient.getAppleAppStoreInfo(appId: 'nonexistent'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should search apps successfully', () async {
        final mockResponse = {
          'resultCount': 2,
          'results': [
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'bundleId': 'net.whatsapp.WhatsApp',
              'formattedPrice': 'Free',
            },
            {
              'trackId': 284882215,
              'trackName': 'Facebook',
              'artistName': 'Meta Platforms, Inc.',
              'bundleId': 'com.facebook.Facebook',
              'formattedPrice': 'Free',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('search?term=social'));
          return http.Response(json.encode(mockResponse), 200);
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        final results = await testClient.searchAppleAppStore('social');

        expect(results, hasLength(2));
        expect(results[0].name, equals('WhatsApp Messenger'));
        expect(results[1].name, equals('Facebook'));
      });

      test('should handle HTTP errors', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Server Error', 500);
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        expect(
          () => testClient.getAppleAppStoreInfo(appId: '123'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should fetch multiple apps successfully', () async {
        final mockResponse = {
          'resultCount': 2,
          'results': [
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'bundleId': 'net.whatsapp.WhatsApp',
              'formattedPrice': 'Free',
            },
            {
              'trackId': 284882215,
              'trackName': 'Facebook',
              'artistName': 'Meta Platforms, Inc.',
              'bundleId': 'com.facebook.Facebook',
              'formattedPrice': 'Free',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          expect(
            request.url.toString(),
            contains('lookup?id=310633997,284882215'),
          );
          return http.Response(json.encode(mockResponse), 200);
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        final results = await testClient.getMultipleAppleAppStoreInfo([
          '310633997',
          '284882215',
        ]);

        expect(results, hasLength(2));
        expect(results['310633997']?.name, equals('WhatsApp Messenger'));
        expect(results['284882215']?.name, equals('Facebook'));
      });

      test('should handle empty app IDs list', () async {
        expect(
          () => client.getMultipleAppleAppStoreInfo([]),
          throwsA(isA<AppStoreException>()),
        );
      });
    });

    group('Google Play Store', () {
      test('should fetch app info successfully', () async {
        final mockHtml = '''
          <html>
            <head><title>WhatsApp Messenger - Apps on Google Play</title></head>
            <body>
              <h1 itemprop="name"><span>WhatsApp Messenger</span></h1>
              <a href="/store/apps/developer?id=WhatsApp+LLC">WhatsApp LLC</a>
              <div aria-label="Rated 4.4 stars out of five stars">4.4</div>
              <div itemprop="description">WhatsApp is a free messaging app</div>
              <img alt="Icon image" src="https://example.com/icon.png">
              <a itemprop="genre">Communication</a>
              <div>Version 2.23.24.76</div>
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('play.google.com'));
          expect(request.url.toString(), contains('id=com.whatsapp'));
          return http.Response(mockHtml, 200);
        });

        final googleStore = GooglePlayStore(httpClient: mockClient);
        final testClient = AppStoreClient(googlePlayStore: googleStore);

        final appInfo = await testClient.getGooglePlayAppInfo('com.whatsapp');

        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.developer, equals('WhatsApp LLC'));
        expect(appInfo.rating, equals(4.4));
        expect(appInfo.description, equals('WhatsApp is a free messaging app'));
        expect(appInfo.iconUrl, equals('https://example.com/icon.png'));
        expect(appInfo.category, equals('Communication'));
        expect(appInfo.version, equals('2.23.24.76'));
      });

      test('should handle app not found', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });

        final googleStore = GooglePlayStore(httpClient: mockClient);
        final testClient = AppStoreClient(googlePlayStore: googleStore);

        expect(
          () => testClient.getGooglePlayAppInfo('nonexistent.app'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should handle malformed HTML gracefully', () async {
        final mockHtml = '<html><body><h1>Broken HTML</body></html>';

        final mockClient = MockClient((request) async {
          return http.Response(mockHtml, 200);
        });

        final googleStore = GooglePlayStore(httpClient: mockClient);
        final testClient = AppStoreClient(googlePlayStore: googleStore);

        final appInfo = await testClient.getGooglePlayAppInfo('com.test');

        // Should not throw, but return default values
        expect(appInfo.name, isNotNull);
        expect(appInfo.developer, isNotNull);
      });

      test('should fetch multiple apps successfully', () async {
        final mockHtml1 = '''
          <html>
            <body>
              <h1 itemprop="name"><span>WhatsApp Messenger</span></h1>
              <a href="/store/apps/developer?id=WhatsApp+LLC">WhatsApp LLC</a>
              <div aria-label="Rated 4.4 stars out of five stars">4.4</div>
            </body>
          </html>
        ''';

        final mockHtml2 = '''
          <html>
            <body>
              <h1 itemprop="name"><span>Facebook</span></h1>
              <a href="/store/apps/developer?id=Meta+Platforms">Meta Platforms, Inc.</a>
              <div aria-label="Rated 3.8 stars out of five stars">3.8</div>
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          if (request.url.toString().contains('id=com.whatsapp')) {
            return http.Response(mockHtml1, 200);
          } else if (request.url.toString().contains(
            'id=com.facebook.katana',
          )) {
            return http.Response(mockHtml2, 200);
          }
          return http.Response('Not Found', 404);
        });

        final googleStore = GooglePlayStore(httpClient: mockClient);
        final testClient = AppStoreClient(googlePlayStore: googleStore);

        final results = await testClient.getMultipleGooglePlayAppInfo([
          'com.whatsapp',
          'com.facebook.katana',
        ]);

        expect(results, hasLength(2));
        expect(results['com.whatsapp']?.name, equals('WhatsApp Messenger'));
        expect(results['com.facebook.katana']?.name, equals('Facebook'));
      });

      test('should handle empty package IDs list', () async {
        expect(
          () => client.getMultipleGooglePlayAppInfo([]),
          throwsA(isA<AppStoreException>()),
        );
      });
    });

    group('Error Handling', () {
      test('should handle network timeouts', () async {
        final mockClient = MockClient((request) async {
          throw Exception('Network timeout');
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        expect(
          () => testClient.getAppleAppStoreInfo(appId: '123'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should handle invalid JSON responses', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Invalid JSON', 200);
        });

        final appleStore = AppleAppStore(httpClient: mockClient);
        final testClient = AppStoreClient(appleAppStore: appleStore);

        expect(
          () => testClient.getAppleAppStoreInfo(appId: '123'),
          throwsA(isA<AppStoreException>()),
        );
      });
    });
  });
}
