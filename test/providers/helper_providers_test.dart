import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seven/providers/helper_providers.dart';

void main() {
  group('bottomNavigationProvider', () {
    test('defaults to the home tab', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(bottomNavigationProvider), 0);
    });

    test('updates the active tab index', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(bottomNavigationProvider.notifier).state = 2;

      expect(container.read(bottomNavigationProvider), 2);
    });
  });

  group('scrollProvider', () {
    test('starts with bottom navigation visible', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final scrollState = container.read(scrollProvider(0));

      expect(scrollState.crossFadeState, isFalse);
      expect(scrollState.scrollController, isNotNull);
    });
  });
}
