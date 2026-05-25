import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:seven/core/core.dart';
import 'package:seven/core/storage/shared_preferences_data.dart';
import 'package:seven/core/theme/dark_theme.dart';

/// Resets singletons and seeds [SharedPreferences] before each test.
Future<void> initTestEnvironment({
  Map<String, Object> preferences = const {},
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(preferences);
  SPD.resetForTesting();
  DimensionUtil.resetForTesting();
}

/// Wraps [child] with dimension scaling and optional Riverpod overrides.
Widget buildTestHarness({
  required Widget child,
  List<Override> overrides = const [],
  ThemeData? theme,
}) {
  return ProviderScope(
    overrides: overrides,
    child: DimensionUtilInit(
      scaleType: ScaleType.WIDTH,
      builder: (context, _) => MaterialApp(
        theme: theme ?? darkTheme,
        home: child,
      ),
      child: const SizedBox.shrink(),
    ),
  );
}

/// Wraps [child] with a [GoRouter] for navigation-focused widget tests.
Widget buildRouterHarness({
  required GoRouter router,
  List<Override> overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: DimensionUtilInit(
      scaleType: ScaleType.WIDTH,
      builder: (context, _) => MaterialApp.router(
        theme: darkTheme,
        routerConfig: router,
      ),
      child: const SizedBox.shrink(),
    ),
  );
}

Future<void> pumpHarness(
  WidgetTester tester,
  Widget harness, {
  Duration settleTimeout = const Duration(seconds: 5),
}) async {
  await tester.pumpWidget(harness);
  await tester.pumpAndSettle(settleTimeout);
}
