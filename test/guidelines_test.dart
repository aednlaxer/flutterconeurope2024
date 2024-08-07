import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

    expectLater(tester, meetsGuideline(LabelLengthGuideline()));
    expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    expectLater(tester, meetsGuideline(textContrastGuideline));
    expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  });
}

/// A guideline to make sure that semantic labels are not too long
class LabelLengthGuideline extends AccessibilityGuideline {
  final int maxLength;

  LabelLengthGuideline({this.maxLength = 80});

  @override
  String get description => 'Check that semantic labels are not too long.';

  @override
  FutureOr<Evaluation> evaluate(WidgetTester tester) {
    Evaluation result = const Evaluation.pass();

    for (final RenderView view in tester.binding.renderViews) {
      result += _traverse(view.owner!.semanticsOwner!.rootSemanticsNode!);
    }

    return result;
  }

  Evaluation _traverse(SemanticsNode node) {
    Evaluation result = const Evaluation.pass();

    node.visitChildren((SemanticsNode child) {
      result += _traverse(child);
      return true;
    });

    if (node.isMergedIntoParent ||
        node.isInvisible ||
        node.hasFlag(SemanticsFlag.isHidden)) {
      return result;
    }

    final SemanticsData data = node.getSemanticsData();

    if (data.label.length > maxLength) {
      result += Evaluation.fail(
        '$node: expected label to be less than $maxLength characters long, '
        'but found ${data.label.length} characters',
      );
    }

    if (data.tooltip.length > maxLength) {
      result += Evaluation.fail(
        '$node: expected tooltip to be less than $maxLength characters long, '
        'but found ${data.tooltip.length} characters',
      );
    }

    return result;
  }
}
