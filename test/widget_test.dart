import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterconeurope2024/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Get "test flavor"
    const testFlavor = String.fromEnvironment('testFlavor');
    const extremeConditions = testFlavor == 'a11yTester';

    double textScale = 1.0;
    bool boldText = false;
    bool highContrast = false;

    if (extremeConditions) {
      // This is a bit extreme but it's here to make tests fail because the app
      // is not designed to work in these conditions
      textScale = 10.0;

      debugSemanticsDisableAnimations = true;
      boldText = true;
      highContrast = true;
    }

    await tester.binding.setSurfaceSize(const Size(200, 200));

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(
          textScaler: TextScaler.linear(textScale),
          boldText: boldText,
          highContrast: highContrast,
        ),
        child: const MyApp(),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
