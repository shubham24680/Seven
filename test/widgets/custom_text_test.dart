import 'package:flutter_test/flutter_test.dart';
import 'package:seven/core/customs/text.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CustomText', () {
    testWidgets('renders provided text', (tester) async {
      await pumpHarness(
        tester,
        buildTestHarness(child: const CustomText(text: 'Seven')),
      );

      expect(find.text('Seven'), findsOneWidget);
    });

    testWidgets('capitalizes the first word when enabled', (tester) async {
      await pumpHarness(
        tester,
        buildTestHarness(
          child: const CustomText(
            text: 'action',
            capitalFirstWord: true,
          ),
        ),
      );

      expect(find.text('Action'), findsOneWidget);
    });
  });
}
