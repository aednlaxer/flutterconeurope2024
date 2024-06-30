import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterconeurope2024/main.dart';

void main() {
  /// A counter increment test that also checks against accessibility guidelines
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    expectLater(tester, meetsGuideline(textContrastGuideline));
    expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  });
}
