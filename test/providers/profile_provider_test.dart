import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seven/providers/profile_provider.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ProfileProvider', () {
    test('loads persisted profile data on startup', () async {
      await initTestEnvironment(preferences: {
        'name': 'Neo',
        'gender_index': 1,
        'profile_pic_index': 3,
        'date_of_birth': '1999-03-31',
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(profileProvider.notifier).loadData();

      final state = container.read(profileProvider);
      expect(state.name, 'Neo');
      expect(state.genderIndex, 1);
      expect(state.profilePicIndex, 3);
      expect(state.dateOfBirth, '1999-03-31');
    });

    test('toggle flips tryEditing', () async {
      await initTestEnvironment();
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(profileProvider.notifier).loadData();

      final notifier = container.read(profileProvider.notifier);

      expect(container.read(profileProvider).tryEditing, isFalse);
      notifier.toggle();
      expect(container.read(profileProvider).tryEditing, isTrue);
      notifier.toggle();
      expect(container.read(profileProvider).tryEditing, isFalse);
    });

    test('setProfileIndexTo and setGenderIndexTo update state', () async {
      await initTestEnvironment();
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(profileProvider.notifier).loadData();

      final notifier = container.read(profileProvider.notifier);
      notifier.setProfileIndexTo(4);
      notifier.setGenderIndexTo(0);

      final state = container.read(profileProvider);
      expect(state.profilePicIndex, 4);
      expect(state.genderIndex, 0);
    });

    test('saveData persists edited profile fields', () async {
      await initTestEnvironment();
      final container = ProviderContainer(
        overrides: [
          profileProvider.overrideWith(
            (ref) => ProfileProvider(loadOnInit: false),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(profileProvider.notifier);
      await notifier.loadData();
      notifier.setProfileIndexTo(2);
      notifier.setGenderIndexTo(1);
      container.read(profileProvider).nameController.text = 'Trinity';
      container.read(profileProvider).dateOfBirthController.text = '1985-02-14';

      await notifier.saveData();

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('name'), 'Trinity');
      expect(prefs.getInt('profile_pic_index'), 2);
      expect(prefs.getInt('gender_index'), 1);
      expect(prefs.getString('date_of_birth'), '1985-02-14');
    });
  });
}
