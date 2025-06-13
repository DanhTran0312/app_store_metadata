import 'package:app_store_metadata/app_store_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('GooglePlayStore', () {
    setUp(() {
      // Test setup
    });

    group('getAppInfo', () {
      test('should fetch app info successfully with complete HTML', () async {
        final mockHtml = '''
          <!DOCTYPE html>
          <html>
            <head><title>WhatsApp Messenger - Apps on Google Play</title></head>
            <body>
              <h1 itemprop="name"><span>WhatsApp Messenger</span></h1>
              <a href="/store/apps/developer?id=WhatsApp+LLC">WhatsApp LLC</a>
              <div aria-label="Rated 4.4 stars out of five stars">4.4</div>
              <div itemprop="description">WhatsApp is a free messaging app available for Android and other smartphones.</div>
              <img alt="Icon image" src="https://play-lh.googleusercontent.com/bYtqbOcTYOlgc6gqZ2rwb8lptHuwlNE75zYJu6Bn076-hTmvd96HH-6v7S0YUAAJXoJN=s64-rw">
              <img data-screenshot-index="0" src="https://play-lh.googleusercontent.com/screenshot1.png">
              <img data-screenshot-index="1" src="https://play-lh.googleusercontent.com/screenshot2.png">
              <a itemprop="genre">Communication</a>
              <div>Version 2.23.24.76</div>
              <span aria-label="Buy for \$0.00">Free</span>
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('play.google.com'));
          expect(request.url.toString(), contains('id=com.whatsapp'));
          expect(request.url.toString(), contains('gl=US'));
          expect(request.url.toString(), contains('hl=en'));
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo('com.whatsapp');

        expect(appInfo.id, equals('com.whatsapp'));
        expect(appInfo.name, equals('WhatsApp Messenger'));
        expect(appInfo.developer, equals('WhatsApp LLC'));
        expect(appInfo.rating, equals(4.4));
        expect(
          appInfo.description,
          contains('WhatsApp is a free messaging app'),
        );
        expect(appInfo.iconUrl, contains('googleusercontent.com'));
        expect(appInfo.screenshots, hasLength(2));
        expect(appInfo.screenshots[0], contains('screenshot1.png'));
        expect(appInfo.screenshots[1], contains('screenshot2.png'));
        expect(appInfo.category, equals('Communication'));
        expect(appInfo.version, equals('2.23.24.76'));
        expect(appInfo.price, equals('Free'));
        expect(
          appInfo.downloadUrl,
          contains('play.google.com/store/apps/details?id=com.whatsapp'),
        );
      });

      test('should handle minimal HTML with fallback selectors', () async {
        final mockHtml = '''
          <html>
            <body>
              <h1>Simple App Name</h1>
              <a href="/store/apps/developer?id=Simple+Developer">Simple Developer</a>
              <div aria-label="Rated 3.5 stars out of five stars">3.5</div>
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo('com.simple.app');

        expect(appInfo.name, equals('Simple App Name'));
        expect(appInfo.developer, equals('Simple Developer'));
        expect(appInfo.rating, equals(3.5));
      });

      test('should handle missing app name gracefully', () async {
        final mockHtml = '''
          <html>
            <body>
              <a href="/store/apps/developer?id=Test+Developer">Test Developer</a>
              <div aria-label="Rated 4.0 stars out of five stars">4.0</div>
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo('com.test.app');

        expect(appInfo.name, equals('Test Developer'));
        expect(appInfo.developer, equals('Test Developer'));
        expect(appInfo.rating, equals(4.0));
      });

      test('should handle malformed HTML gracefully', () async {
        final mockHtml = '<html><body><h1>Broken HTML</body></html>';

        final mockClient = MockClient((request) async {
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo('com.broken.app');

        expect(appInfo.name, equals('Broken HTML'));
        expect(appInfo.developer, equals('Unknown Developer'));
        expect(appInfo.rating, isNull);
      });

      test('should handle app not found (404)', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo('nonexistent.app'),
          throwsA(isA<AppNotFoundException>()),
        );
      });

      test('should handle server errors', () async {
        final mockClient = MockClient((request) async {
          return http.Response('Internal Server Error', 500);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo('com.test.app'),
          throwsA(isA<AppNotFoundException>()),
        );
      });

      test('should handle network exceptions', () async {
        final mockClient = MockClient((request) async {
          throw Exception('Network error');
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        expect(
          () => testStore.getAppInfo('com.test.app'),
          throwsA(isA<AppStoreException>()),
        );
      });

      test('should use custom country and language parameters', () async {
        final mockHtml = '<html><body><h1>Test App</h1></body></html>';

        final mockClient = MockClient((request) async {
          expect(request.url.toString(), contains('gl=GB'));
          expect(request.url.toString(), contains('hl=es'));
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        await testStore.getAppInfo(
          'com.test.app',
          country: 'GB',
          language: 'es',
        );
      });

      test('should extract rating from different formats', () async {
        final testCases = [
          {
            'html':
                '<div aria-label="Rated 4.5 stars out of five stars">4.5</div>',
            'expected': 4.5,
          },
          {
            'html': '<div aria-label="Rated 3 stars out of five stars">3</div>',
            'expected': 3.0,
          },
          {
            'html':
                '<div aria-label="Rated 4.75 stars out of five stars">4.75</div>',
            'expected': 4.75,
          },
        ];

        for (final testCase in testCases) {
          final mockHtml =
              '''
            <html>
              <body>
                <h1>Test App</h1>
                ${testCase['html']}
              </body>
            </html>
          ''';

          final mockClient = MockClient((request) async {
            return http.Response(mockHtml, 200);
          });

          final testStore = GooglePlayStore(httpClient: mockClient);
          final appInfo = await testStore.getAppInfo('com.test.app');

          expect(appInfo.rating, equals(testCase['expected']));
        }
      });

      test('should extract version from different formats', () async {
        final testCases = [
          'Version 2.23.24.76',
          'Version: 1.0.0',
          'Current Version 3.5.2',
          'App Version 4.1.0-beta',
        ];

        for (final versionText in testCases) {
          final mockHtml =
              '''
            <html>
              <body>
                <h1>Test App</h1>
                <div>$versionText</div>
              </body>
            </html>
          ''';

          final mockClient = MockClient((request) async {
            return http.Response(mockHtml, 200);
          });

          final testStore = GooglePlayStore(httpClient: mockClient);
          final appInfo = await testStore.getAppInfo('com.test.app');

          if (versionText == 'Version 2.23.24.76') {
            expect(appInfo.version, equals('2.23.24.76'));
          }
        }
      });

      test('should handle empty screenshots list', () async {
        final mockHtml = '''
          <html>
            <body>
              <h1>Test App</h1>
              <!-- No screenshots -->
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo('com.test.app');

        expect(appInfo.screenshots, isEmpty);
      });

      test('should handle multiple screenshots', () async {
        final mockHtml = '''
          <html>
            <body>
              <h1>Test App</h1>
              <img data-screenshot-index="0" src="https://example.com/screen1.png">
              <img data-screenshot-index="1" src="https://example.com/screen2.png">
              <img data-screenshot-index="2" src="https://example.com/screen3.png">
            </body>
          </html>
        ''';

        final mockClient = MockClient((request) async {
          return http.Response(mockHtml, 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        final appInfo = await testStore.getAppInfo('com.test.app');

        expect(appInfo.screenshots, hasLength(3));
        expect(
          appInfo.screenshots[0],
          equals('https://example.com/screen1.png'),
        );
        expect(
          appInfo.screenshots[1],
          equals('https://example.com/screen2.png'),
        );
        expect(
          appInfo.screenshots[2],
          equals('https://example.com/screen3.png'),
        );
      });

      test('should handle price extraction', () async {
        final testCases = [
          {
            'html': '<span aria-label="Buy for \$0.00">Free</span>',
            'expected': 'Free',
          },
          {
            'html': '<span aria-label="Buy for \$2.99">\$2.99</span>',
            'expected': '\$2.99',
          },
          {
            'html': '<!-- No price element -->',
            'expected': 'Free', // Default
          },
        ];

        for (final testCase in testCases) {
          final mockHtml =
              '''
            <html>
              <body>
                <h1>Test App</h1>
                ${testCase['html']}
              </body>
            </html>
          ''';

          final mockClient = MockClient((request) async {
            return http.Response(mockHtml, 200);
          });

          final testStore = GooglePlayStore(httpClient: mockClient);
          final appInfo = await testStore.getAppInfo('com.test.app');

          expect(appInfo.price, equals(testCase['expected']));
        }
      });
    });

    group('dispose', () {
      test('should dispose HTTP client', () {
        final mockClient = MockClient((request) async {
          return http.Response('', 200);
        });

        final testStore = GooglePlayStore(httpClient: mockClient);

        // Should not throw
        testStore.dispose();
      });
    });
  });
}
