import 'package:app_store_metadata/app_store_metadata.dart';
import 'package:test/test.dart';

void main() {
  group('AppInfo', () {
    group('constructor', () {
      test('should create AppInfo with required fields', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
        );

        expect(appInfo.id, equals('123'));
        expect(appInfo.name, equals('Test App'));
        expect(appInfo.developer, equals('Test Developer'));
        expect(appInfo.screenshots, isEmpty);
      });

      test('should create AppInfo with all fields', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          description: 'A test application',
          summary: 'Test summary',
          rating: 4.5,
          ratingCount: 1000,
          price: 'Free',
          currency: 'USD',
          iconUrl: 'https://example.com/icon.png',
          screenshots: [
            'https://example.com/screen1.png',
            'https://example.com/screen2.png',
          ],
          category: 'Productivity',
          contentRating: '4+',
          version: '1.0.0',
          lastUpdated: '2023-01-01',
          downloadUrl: 'https://example.com/download',
          downloads: 50000,
          bundleId: 'com.test.app',
          additionalInfo: {'key': 'value'},
        );

        expect(appInfo.id, equals('123'));
        expect(appInfo.name, equals('Test App'));
        expect(appInfo.developer, equals('Test Developer'));
        expect(appInfo.description, equals('A test application'));
        expect(appInfo.summary, equals('Test summary'));
        expect(appInfo.rating, equals(4.5));
        expect(appInfo.ratingCount, equals(1000));
        expect(appInfo.price, equals('Free'));
        expect(appInfo.currency, equals('USD'));
        expect(appInfo.iconUrl, equals('https://example.com/icon.png'));
        expect(appInfo.screenshots, hasLength(2));
        expect(
          appInfo.screenshots[0],
          equals('https://example.com/screen1.png'),
        );
        expect(
          appInfo.screenshots[1],
          equals('https://example.com/screen2.png'),
        );
        expect(appInfo.category, equals('Productivity'));
        expect(appInfo.contentRating, equals('4+'));
        expect(appInfo.version, equals('1.0.0'));
        expect(appInfo.lastUpdated, equals('2023-01-01'));
        expect(appInfo.downloadUrl, equals('https://example.com/download'));
        expect(appInfo.downloads, equals(50000));
        expect(appInfo.bundleId, equals('com.test.app'));
        expect(appInfo.additionalInfo?['key'], equals('value'));
      });

      test('should handle null screenshots list', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          screenshots: null,
        );

        expect(appInfo.screenshots, isEmpty);
      });
    });

    group('fromJson', () {
      test('should create AppInfo from complete JSON', () {
        final json = {
          'id': '123',
          'name': 'Test App',
          'developer': 'Test Developer',
          'description': 'A test application',
          'summary': 'Test summary',
          'rating': 4.5,
          'ratingCount': 1000,
          'price': 'Free',
          'currency': 'USD',
          'iconUrl': 'https://example.com/icon.png',
          'screenshots': [
            'https://example.com/screen1.png',
            'https://example.com/screen2.png',
          ],
          'category': 'Productivity',
          'contentRating': '4+',
          'version': '1.0.0',
          'lastUpdated': '2023-01-01',
          'downloadUrl': 'https://example.com/download',
          'downloads': 50000,
          'bundleId': 'com.test.app',
          'additionalInfo': {'key': 'value'},
        };

        final appInfo = AppInfo.fromJson(json);

        expect(appInfo.id, equals('123'));
        expect(appInfo.name, equals('Test App'));
        expect(appInfo.developer, equals('Test Developer'));
        expect(appInfo.description, equals('A test application'));
        expect(appInfo.summary, equals('Test summary'));
        expect(appInfo.rating, equals(4.5));
        expect(appInfo.ratingCount, equals(1000));
        expect(appInfo.price, equals('Free'));
        expect(appInfo.currency, equals('USD'));
        expect(appInfo.iconUrl, equals('https://example.com/icon.png'));
        expect(appInfo.screenshots, hasLength(2));
        expect(appInfo.category, equals('Productivity'));
        expect(appInfo.contentRating, equals('4+'));
        expect(appInfo.version, equals('1.0.0'));
        expect(appInfo.lastUpdated, equals('2023-01-01'));
        expect(appInfo.downloadUrl, equals('https://example.com/download'));
        expect(appInfo.downloads, equals(50000));
        expect(appInfo.bundleId, equals('com.test.app'));
        expect(appInfo.additionalInfo?['key'], equals('value'));
      });

      test('should create AppInfo from minimal JSON', () {
        final json = {
          'id': '123',
          'name': 'Test App',
          'developer': 'Test Developer',
        };

        final appInfo = AppInfo.fromJson(json);

        expect(appInfo.id, equals('123'));
        expect(appInfo.name, equals('Test App'));
        expect(appInfo.developer, equals('Test Developer'));
        expect(appInfo.description, isNull);
        expect(appInfo.rating, isNull);
        expect(appInfo.screenshots, isEmpty);
      });

      test('should handle null screenshots in JSON', () {
        final json = {
          'id': '123',
          'name': 'Test App',
          'developer': 'Test Developer',
          'screenshots': null,
        };

        final appInfo = AppInfo.fromJson(json);

        expect(appInfo.screenshots, isEmpty);
      });

      test('should handle integer rating in JSON', () {
        final json = {
          'id': '123',
          'name': 'Test App',
          'developer': 'Test Developer',
          'rating': 4,
        };

        final appInfo = AppInfo.fromJson(json);

        expect(appInfo.rating, equals(4.0));
      });
    });

    group('toJson', () {
      test('should convert AppInfo to JSON', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          description: 'A test application',
          rating: 4.5,
          ratingCount: 1000,
          price: 'Free',
          screenshots: ['https://example.com/screen1.png'],
          category: 'Productivity',
          version: '1.0.0',
          bundleId: 'com.test.app',
          additionalInfo: {'key': 'value'},
        );

        final json = appInfo.toJson();

        expect(json['id'], equals('123'));
        expect(json['name'], equals('Test App'));
        expect(json['developer'], equals('Test Developer'));
        expect(json['description'], equals('A test application'));
        expect(json['rating'], equals(4.5));
        expect(json['ratingCount'], equals(1000));
        expect(json['price'], equals('Free'));
        expect(json['screenshots'], hasLength(1));
        expect(json['category'], equals('Productivity'));
        expect(json['version'], equals('1.0.0'));
        expect(json['bundleId'], equals('com.test.app'));
        expect(json['additionalInfo']['key'], equals('value'));
      });

      test('should handle null values in toJson', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          description: null,
          rating: null,
          screenshots: [],
        );

        final json = appInfo.toJson();

        expect(json['id'], equals('123'));
        expect(json['name'], equals('Test App'));
        expect(json['developer'], equals('Test Developer'));
        expect(json['description'], isNull);
        expect(json['rating'], isNull);
        expect(json['screenshots'], isEmpty);
      });
    });

    group('toString', () {
      test('should return formatted string representation', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          rating: 4.5,
        );

        final stringRepresentation = appInfo.toString();

        expect(stringRepresentation, contains('123'));
        expect(stringRepresentation, contains('Test App'));
        expect(stringRepresentation, contains('Test Developer'));
        expect(stringRepresentation, contains('4.5'));
      });

      test('should handle null rating in toString', () {
        final appInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          rating: null,
        );

        final stringRepresentation = appInfo.toString();

        expect(stringRepresentation, contains('123'));
        expect(stringRepresentation, contains('Test App'));
        expect(stringRepresentation, contains('Test Developer'));
        expect(stringRepresentation, contains('null'));
      });
    });

    group('JSON round-trip', () {
      test('should maintain data integrity through JSON conversion', () {
        final originalAppInfo = AppInfo(
          id: '123',
          name: 'Test App',
          developer: 'Test Developer',
          description: 'A test application',
          rating: 4.5,
          ratingCount: 1000,
          price: 'Free',
          currency: 'USD',
          iconUrl: 'https://example.com/icon.png',
          screenshots: [
            'https://example.com/screen1.png',
            'https://example.com/screen2.png',
          ],
          category: 'Productivity',
          contentRating: '4+',
          version: '1.0.0',
          lastUpdated: '2023-01-01',
          downloadUrl: 'https://example.com/download',
          downloads: 50000,
          bundleId: 'com.test.app',
          additionalInfo: {'key': 'value'},
        );

        final json = originalAppInfo.toJson();
        final reconstructedAppInfo = AppInfo.fromJson(json);

        expect(reconstructedAppInfo.id, equals(originalAppInfo.id));
        expect(reconstructedAppInfo.name, equals(originalAppInfo.name));
        expect(
          reconstructedAppInfo.developer,
          equals(originalAppInfo.developer),
        );
        expect(
          reconstructedAppInfo.description,
          equals(originalAppInfo.description),
        );
        expect(reconstructedAppInfo.rating, equals(originalAppInfo.rating));
        expect(
          reconstructedAppInfo.ratingCount,
          equals(originalAppInfo.ratingCount),
        );
        expect(reconstructedAppInfo.price, equals(originalAppInfo.price));
        expect(reconstructedAppInfo.currency, equals(originalAppInfo.currency));
        expect(reconstructedAppInfo.iconUrl, equals(originalAppInfo.iconUrl));
        expect(
          reconstructedAppInfo.screenshots,
          equals(originalAppInfo.screenshots),
        );
        expect(reconstructedAppInfo.category, equals(originalAppInfo.category));
        expect(
          reconstructedAppInfo.contentRating,
          equals(originalAppInfo.contentRating),
        );
        expect(reconstructedAppInfo.version, equals(originalAppInfo.version));
        expect(
          reconstructedAppInfo.lastUpdated,
          equals(originalAppInfo.lastUpdated),
        );
        expect(
          reconstructedAppInfo.downloadUrl,
          equals(originalAppInfo.downloadUrl),
        );
        expect(
          reconstructedAppInfo.downloads,
          equals(originalAppInfo.downloads),
        );
        expect(reconstructedAppInfo.bundleId, equals(originalAppInfo.bundleId));
        expect(
          reconstructedAppInfo.additionalInfo,
          equals(originalAppInfo.additionalInfo),
        );
      });
    });
  });
}
