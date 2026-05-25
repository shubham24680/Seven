import 'package:flutter_test/flutter_test.dart';
import 'package:seven/core/utils/widgets.dart';

void main() {
  group('getRuntime', () {
    test('returns null for invalid runtime values', () {
      expect(getRuntime(null), isNull);
      expect(getRuntime(0), isNull);
      expect(getRuntime(-10), isNull);
    });

    test('formats hours and minutes', () {
      expect(getRuntime(95), '1 h 35 min');
      expect(getRuntime(60), '1 h');
      expect(getRuntime(45), '45 min');
    });
  });

  group('getCurrencyFormat', () {
    test('returns null for invalid amounts', () {
      expect(getCurrencyFormat(null, 'en_US'), isNull);
      expect(getCurrencyFormat(0, 'en_US'), isNull);
    });

    test('formats USD without decimals', () {
      expect(getCurrencyFormat(1500000, 'en_US'), r'$ 1,500,000');
    });
  });

  group('getImageUrl', () {
    test('returns null for empty paths', () {
      expect(getImageUrl(null), isNull);
      expect(getImageUrl(''), isNull);
    });

    test('builds a TMDB image URL for valid paths', () {
      final url = getImageUrl('/poster.jpg');

      expect(url, isNotNull);
      expect(url, contains('/poster.jpg'));
    });
  });
}
