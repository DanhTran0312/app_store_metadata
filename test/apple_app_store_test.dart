import 'dart:convert';

import 'package:app_store_metadata/app_store_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('AppleAppStore', () {
    late AppleAppStore store;

    setUp(() {
      store = AppleAppStore();
    });

    group('getAppInfo', () {
      test('should fetch app info by appId successfully', () async {
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
              'artworkUrl512': 'https://example.com/icon512.png',
              'artworkUrl100': 'https://example.com/icon100.png',
              'screenshotUrls': [
                'https://example.com/screenshot1.png',
                'https://example.com/screenshot2.png',
              ],
              'ipadScreenshotUrls': ['https://example.com/ipad_screenshot.png'],
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

        final testStore = AppleAppStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo(appId: '310633997');

        expect(appInfo.id, equals('310633997'));
        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.developer, equals('WhatsApp Inc.'));
        expect(appInfo.rating, equals(4.69032));
        expect(appInfo.ratingCount, equals(15936654));
        expect(appInfo.price, equals('Free'));
        expect(appInfo.currency, equals('USD'));
        expect(appInfo.version, equals('25.17.81'));
        expect(appInfo.bundleId, equals('net.whatsapp.WhatsApp'));
        expect(appInfo.category, equals('Social Networking'));
        expect(appInfo.contentRating, equals('12+'));
        expect(appInfo.iconUrl, equals('https://example.com/icon512.png'));
        expect(appInfo.screenshots, hasLength(3));
        expect(
          appInfo.screenshots,
          contains('https://example.com/screenshot1.png'),
        );
        expect(
          appInfo.screenshots,
          contains('https://example.com/ipad_screenshot.png'),
        );
        expect(
          appInfo.description,
          equals('WhatsApp Messenger is a FREE messaging app'),
        );
        expect(appInfo.summary, equals('Bug fixes and improvements'));
        expect(appInfo.lastUpdated, equals('2025-06-10T17:00:36Z'));
        expect(
          appInfo.downloadUrl,
          equals('https://apps.apple.com/app/id310633997'),
        );
        expect(appInfo.additionalInfo?['fileSize'], equals(257449984));
        expect(appInfo.additionalInfo?['minimumOsVersion'], equals('15.1'));
      });

      test('should fetch app info by bundleId with direct lookup', () async {
        final mockResponse = {
          'resultCount': 1,
          'results': [
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'bundleId': 'net.whatsapp.WhatsApp',
              'formattedPrice': 'Free',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          expect(
            request.url.toString(),
            contains('bundleId=net.whatsapp.WhatsApp'),
          );
          return http.Response(json.encode(mockResponse), 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo(
          bundleId: 'net.whatsapp.WhatsApp',
        );

        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.bundleId, equals('net.whatsapp.WhatsApp'));
      });

      test('should fetch app info by bundleId with search fallback', () async {
        final mockSearchResponse = {
          'resultCount': 2,
          'results': [
            {
              'trackId': 123456,
              'trackName': 'Other App',
              'bundleId': 'com.other.app',
            },
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'bundleId': 'net.whatsapp.WhatsApp',
              'formattedPrice': 'Free',
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

        final testStore = AppleAppStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo(
          bundleId: 'net.whatsapp.WhatsApp',
        );

        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.bundleId, equals('net.whatsapp.WhatsApp'));
      });

      test(
        'should throw exception when neither appId nor bundleId provided',
        () async {
          expect(() => store.getAppInfo(), throwsA(isA<AppStoreException>()));
        },
      );

      test('should handle app not found by appId', () async {
        final mockClient = MockClient((request) async {
          return http.Response(
            json.encode({'resultCount': 0, 'results': []}),
            200,
          );
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo(appId: 'nonexistent'),
          throwsA(isA<AppNotFoundException>()),
        );
      });

      test('should handle app not found by bundleId', () async {
        final mockClient = MockClient((request) async {
          if (request.url.toString().contains('bundleId=')) {
            return http.Response(
              json.encode({'resultCount': 0, 'results': []}),
              200,
            );
          } else if (request.url.toString().contains('search?term=')) {
            return http.Response(
              json.encode({'resultCount': 0, 'results': []}),
              200,
            );
          }
          return http.Response('Not found', 404);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo(bundleId: 'nonexistent.bundle'),
          throwsA(isA<AppNotFoundException>()),
        );
      });

      test('should handle HTTP errors', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Server Error', 500);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo(appId: '123'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should handle invalid JSON', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Invalid JSON', 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo(appId: '123'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should handle network exceptions', () async {
        final mockClient = MockClient((request) async {
          throw Exception('Network error');
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo(appId: '123'),
          throwsA(isA<AppStoreException>()),
        );
      });
    });

    group('searchApps', () {
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
              'primaryGenreName': 'Social Networking',
            },
            {
              'trackId': 284882215,
              'trackName': 'Facebook',
              'artistName': 'Meta Platforms, Inc.',
              'bundleId': 'com.facebook.Facebook',
              'formattedPrice': 'Free',
              'primaryGenreName': 'Social Networking',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('search?term=social'));
          expect(request.url.toString(), contains('country=US'));
          expect(request.url.toString(), contains('limit=10'));
          expect(request.url.toString(), contains('entity=software'));
          return http.Response(json.encode(mockResponse), 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        final results = await testStore.searchApps('social');

        expect(results, hasLength(2));
        expect(results[0].name, equals('WhatsApp Messenger'));
        expect(results[0].developer, equals('WhatsApp Inc.'));
        expect(results[1].name, equals('Facebook'));
        expect(results[1].developer, equals('Meta Platforms, Inc.'));
      });

      test('should handle empty search results', () async {
        final mockResponse = {'resultCount': 0, 'results': []};

        final mockClient = MockClient((request) async {
          return http.Response(json.encode(mockResponse), 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        final results = await testStore.searchApps('nonexistent');

        expect(results, isEmpty);
      });

      test('should handle search with custom parameters', () async {
        final mockResponse = {
          'resultCount': 1,
          'results': [
            {
              'trackId': 310633997,
              'trackName': 'WhatsApp Messenger',
              'artistName': 'WhatsApp Inc.',
              'formattedPrice': 'Free',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('country=GB'));
          expect(request.url.toString(), contains('limit=5'));
          return http.Response(json.encode(mockResponse), 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        final results = await testStore.searchApps(
          'whatsapp',
          country: 'GB',
          limit: 5,
        );

        expect(results, hasLength(1));
      });

      test('should handle search HTTP errors', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Server Error', 500);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        expect(
          () => testStore.searchApps('test'),
          throwsA(isA<AppStoreException>()),
        );
      });
    });

    group('_parseAppStoreJson', () {
      test('should handle minimal JSON data', () async {
        final mockResponse = {
          'resultCount': 1,
          'results': [
            {
              'trackId': 123,
              'trackName': 'Test App',
              'artistName': 'Test Developer',
            },
          ],
        };

        final mockClient = MockClient((request) async {
          return http.Response(json.encode(mockResponse), 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo(appId: '123');

        expect(appInfo.id, equals('123'));
        expect(appInfo.name, equals('Test App'));
        expect(appInfo.developer, equals('Test Developer'));
        expect(appInfo.price, equals('Free')); // Default value
        expect(appInfo.screenshots, isEmpty);
      });

      test('should handle null values gracefully', () async {
        final mockResponse = {
          'resultCount': 1,
          'results': [
            {
              'trackId': 123,
              'trackName': null,
              'artistName': null,
              'averageUserRating': null,
              'description': null,
            },
          ],
        };

        final mockClient = MockClient((request) async {
          return http.Response(json.encode(mockResponse), 200);
        });

        final testStore = AppleAppStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo(appId: '123');

        expect(appInfo.name, equals('Unknown App'));
        expect(appInfo.developer, equals('Unknown Developer'));
        expect(appInfo.rating, isNull);
        expect(appInfo.description, isNull);
      });
    });
  });
}
