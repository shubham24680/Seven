import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seven/main.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('App routing', () {
    testWidgets('redirects first-time visitors to onboarding', (tester) async {
      await initTestEnvironment(preferences: {'first_visit': true});

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('In the Shadows'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });
  });
}
