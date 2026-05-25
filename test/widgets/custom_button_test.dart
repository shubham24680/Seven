import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seven/core/customs/button.dart';
import 'package:seven/core/customs/text.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CustomButton', () {
    testWidgets('elevated button renders label and triggers onPressed',
        (tester) async {
      var tapped = false;

      await pumpHarness(
        tester,
        buildTestHarness(
          child: CustomButton(
            onPressed: () => tapped = true,
            child: const CustomText(text: 'Watch now'),
          ),
        ),
      );

      expect(find.text('Watch now'), findsOneWidget);
      await tester.tap(find.text('Watch now'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('elevated button is disabled when onPressed is null',
        (tester) async {
      await pumpHarness(
        tester,
        buildTestHarness(
          child: CustomButton(
            onPressed: null,
            child: const CustomText(text: 'Disabled'),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('text button type renders tappable label', (tester) async {
      var tapped = false;

      await pumpHarness(
        tester,
        buildTestHarness(
          child: CustomButton(
            buttonType: ButtonType.TEXT,
            icon: 'See all',
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.text('See all'), findsOneWidget);
      await tester.tap(find.text('See all'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
