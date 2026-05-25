import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seven/main.dart';

import '../helpers/test_helpers.dart';

/// Isolated from [routing_test.dart] because the app uses a global [GoRouter]
/// instance that retains navigation state across tests in the same file.
void main() {
  testWidgets('shows the main shell for returning users', (tester) async {
    await initTestEnvironment(preferences: {'first_visit': false});

    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.textContaining('In the Shadows'), findsNothing);
  });
}
