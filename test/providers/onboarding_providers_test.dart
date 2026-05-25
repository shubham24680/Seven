import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seven/providers/onboarding_providers.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('PageState', () {
    test('initial state starts on page 0', () {
      final state = PageState.initial();

      expect(state.currentIndex, 0);
      expect(state.pageController.initialPage, 0);
    });

    test('copyWith updates currentIndex without replacing controller', () {
      final state = PageState.initial();

      final updated = state.copyWith(currentIndex: 1);

      expect(updated.currentIndex, 1);
      expect(updated.pageController, same(state.pageController));
    });
  });

  group('PageProvider', () {
    test('moveToPage updates currentIndex', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(pageProvider.notifier).moveToPage(1);

      expect(container.read(pageProvider).currentIndex, 1);
    });

    test('changeFirstTimeVisitStatus clears first visit flag', () async {
      await initTestEnvironment(preferences: {'first_visit': true});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(pageProvider.notifier).changeFirstTimeVisitStatus();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('first_visit'), isFalse);
    });

    test('changeFirstTimeVisitStatus is a no-op when already completed', () async {
      await initTestEnvironment(preferences: {'first_visit': false});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(pageProvider.notifier).changeFirstTimeVisitStatus();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('first_visit'), isFalse);
    });
  });
}
