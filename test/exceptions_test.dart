import 'package:app_store_metadata/app_store_metadata.dart';
import 'package:test/test.dart';

void main() {
  group('Exceptions', () {
    group('AppStoreException', () {
      test('should create exception with message', () {
        const message = 'Test error message';
        final exception = AppStoreException(message);

        expect(exception.message, equals(message));
        expect(exception.toString(), equals('AppStoreException: $message'));
      });

      test('should be an Exception', () {
        final exception = AppStoreException('Test');
        expect(exception, isA<Exception>());
      });

      test('should have proper string representation', () {
        final exception = AppStoreException('Network error');
        expect(
          exception.toString(),
          equals('AppStoreException: Network error'),
        );
      });
    });

    group('AppNotFoundException', () {
      test('should create exception with message', () {
        const message = 'App not found';
        final exception = AppNotFoundException(message);

        expect(exception.message, equals(message));
        expect(exception.toString(), equals('AppNotFoundException: $message'));
      });

      test('should be an AppStoreException', () {
        final exception = AppNotFoundException('Test');
        expect(exception, isA<AppStoreException>());
      });

      test('should be an Exception', () {
        final exception = AppNotFoundException('Test');
        expect(exception, isA<Exception>());
      });

      test('should have proper string representation', () {
        final exception = AppNotFoundException('App with ID 123 not found');
        expect(
          exception.toString(),
          equals('AppNotFoundException: App with ID 123 not found'),
        );
      });
    });

    group('RateLimitException', () {
      test('should create exception with message', () {
        const message = 'Rate limit exceeded';
        final exception = RateLimitException(message);

        expect(exception.message, equals(message));
        expect(exception.retryAfter, isNull);
        expect(exception.toString(), equals('RateLimitException: $message'));
      });

      test('should create exception with message and retry duration', () {
        const message = 'Rate limit exceeded';
        const retryAfter = Duration(seconds: 60);
        final exception = RateLimitException(message, retryAfter: retryAfter);

        expect(exception.message, equals(message));
        expect(exception.retryAfter, equals(retryAfter));
        expect(exception.toString(), equals('RateLimitException: $message'));
      });

      test('should be an AppStoreException', () {
        final exception = RateLimitException('Test');
        expect(exception, isA<AppStoreException>());
      });

      test('should be an Exception', () {
        final exception = RateLimitException('Test');
        expect(exception, isA<Exception>());
      });

      test('should have proper string representation', () {
        final exception = RateLimitException('Too many requests');
        expect(
          exception.toString(),
          equals('RateLimitException: Too many requests'),
        );
      });

      test('should handle retry after duration', () {
        const retryAfter = Duration(minutes: 5);
        final exception = RateLimitException(
          'Rate limited',
          retryAfter: retryAfter,
        );

        expect(exception.retryAfter, equals(retryAfter));
        expect(exception.retryAfter?.inMinutes, equals(5));
      });
    });

    group('Exception hierarchy', () {
      test('should maintain proper inheritance chain', () {
        final appStoreException = AppStoreException('Base error');
        final appNotFoundException = AppNotFoundException('Not found');
        final rateLimitException = RateLimitException('Rate limited');

        // AppStoreException
        expect(appStoreException, isA<Exception>());
        expect(appStoreException, isA<AppStoreException>());

        // AppNotFoundException
        expect(appNotFoundException, isA<Exception>());
        expect(appNotFoundException, isA<AppStoreException>());
        expect(appNotFoundException, isA<AppNotFoundException>());

        // RateLimitException
        expect(rateLimitException, isA<Exception>());
        expect(rateLimitException, isA<AppStoreException>());
        expect(rateLimitException, isA<RateLimitException>());
      });

      test('should be catchable as AppStoreException', () {
        final exceptions = [
          AppStoreException('Base error'),
          AppNotFoundException('Not found'),
          RateLimitException('Rate limited'),
        ];

        for (final exception in exceptions) {
          expect(() => throw exception, throwsA(isA<AppStoreException>()));
        }
      });

      test('should be catchable as specific exception types', () {
        expect(
          () => throw AppNotFoundException('Not found'),
          throwsA(isA<AppNotFoundException>()),
        );

        expect(
          () => throw RateLimitException('Rate limited'),
          throwsA(isA<RateLimitException>()),
        );
      });
    });

    group('Exception usage scenarios', () {
      test('should handle app not found scenario', () {
        void simulateAppNotFound() {
          throw AppNotFoundException('App with ID "nonexistent" was not found');
        }

        expect(simulateAppNotFound, throwsA(isA<AppNotFoundException>()));

        try {
          simulateAppNotFound();
        } catch (e) {
          expect(e, isA<AppNotFoundException>());
          expect((e as AppNotFoundException).message, contains('nonexistent'));
        }
      });

      test('should handle rate limiting scenario', () {
        void simulateRateLimit() {
          throw RateLimitException(
            'API rate limit exceeded',
            retryAfter: const Duration(seconds: 30),
          );
        }

        expect(simulateRateLimit, throwsA(isA<RateLimitException>()));

        try {
          simulateRateLimit();
        } catch (e) {
          expect(e, isA<RateLimitException>());
          final rateLimitException = e as RateLimitException;
          expect(rateLimitException.message, contains('rate limit'));
          expect(rateLimitException.retryAfter?.inSeconds, equals(30));
        }
      });

      test('should handle generic app store error', () {
        void simulateGenericError() {
          throw AppStoreException('Network connection failed');
        }

        expect(simulateGenericError, throwsA(isA<AppStoreException>()));

        try {
          simulateGenericError();
        } catch (e) {
          expect(e, isA<AppStoreException>());
          expect((e as AppStoreException).message, contains('Network'));
        }
      });
    });
  });
}
