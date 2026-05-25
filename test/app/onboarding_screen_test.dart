import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:seven/core/constants/app_constants.dart';
import 'package:seven/features/onboarding/screens/onboading_screen.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('OnboadingScreen', () {
    testWidgets('renders the first onboarding slide', (tester) async {
      final firstSlide = AppConstants.ONBOARDING.first;

      await pumpHarness(
        tester,
        buildTestHarness(child: const OnboadingScreen()),
      );

      expect(find.textContaining('In the Shadows'), findsOneWidget);
      expect(
        find.textContaining(firstSlide.string3!.split('\n').first),
        findsOneWidget,
      );
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('advances to the second slide when Next is tapped',
        (tester) async {
      await pumpHarness(
        tester,
        buildTestHarness(child: const OnboadingScreen()),
      );

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.textContaining('From the Ashes'), findsOneWidget);
      expect(find.text('Get the vibe'), findsOneWidget);
    });

    testWidgets('completing onboarding navigates to home', (tester) async {
      await initTestEnvironment(preferences: {'first_visit': true});

      final router = GoRouter(
        initialLocation: '/onboarding',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Text('Home screen')),
          ),
          GoRoute(
            path: '/onboarding',
            builder: (context, state) => const OnboadingScreen(),
          ),
        ],
      );

      await tester.pumpWidget(buildRouterHarness(router: router));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.text('Get the vibe'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Home screen'), findsOneWidget);
    });
  });
}
