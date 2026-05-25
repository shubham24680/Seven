import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:seven/features/error/error_screen.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ErrorScreen', () {
    testWidgets('shows no internet copy and retry action', (tester) async {
      var retried = false;

      await pumpHarness(
        tester,
        buildTestHarness(
          child: ErrorScreen(
            goBack: false,
            onPressed: () => retried = true,
          ),
        ),
      );

      expect(find.text('OH NO!'), findsOneWidget);
      expect(find.textContaining('No internet connection'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
      expect(find.text('Back'), findsNothing);

      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();

      expect(retried, isTrue);
    });

    testWidgets('shows no data copy', (tester) async {
      await pumpHarness(
        tester,
        buildTestHarness(
          child: const ErrorScreen(
            errorType: ErrorType.NO_DATA,
            goBack: false,
          ),
        ),
      );

      expect(find.text('OOPS!'), findsOneWidget);
      expect(find.text('No shows found'), findsOneWidget);
    });

    testWidgets('back button pops the current route', (tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) =>
                const Scaffold(body: Text('Home screen')),
          ),
          GoRoute(
            path: '/error',
            builder: (context, state) => const ErrorScreen(),
          ),
        ],
      );

      await initTestEnvironment();
      await tester.pumpWidget(buildRouterHarness(router: router));
      await tester.pumpAndSettle();

      router.push('/error');
      await tester.pumpAndSettle();

      expect(find.text('OH NO!'), findsOneWidget);

      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Home screen'), findsOneWidget);
    });
  });
}
