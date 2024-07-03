# Fluttercon Europe 2024 talk: Testing that your app is accessible to all

Slides and code for the Fluttercon 2024 talk

## Slides

PDF file with slides is located in the root directory. All images should have associated labels, however it's not guaranteed when exporting PDF from Google Slides.

## Running app to play with `accessibility_tools`

Project uses Flutter's default counter app to showcase [`accessibility_tools`](https://pub.dev/packages/accessibility_tools) package. Run app with `flutter un` and open testing panel to change font size and other parameters to check how default app reacts to these changes.

Consider checking out [`accessibility_tools`' repository](https://github.com/rebelappstudio/accessibility_tools/tree/main/example) for an example app to see what issues can be present in an app.

## Running accessibility guidelines tests

Executing the following command runs widget tests with checks against Flutter's [accessibility guidelines](https://api.flutter.dev/flutter/flutter_test/AccessibilityGuideline-class.html):

```
flutter test test/guidelines_test.dart
```

Test fails because floating action button has not semantic label. Adding a semantic label or a tooltip fixes the issue.

Guidelines test also contains a custom guideline to check the semantic label's max acceptable length.

## Running widget tests with modified accessibility options

Running the following command shows no problem with tests:
```
flutter test test/widget_test.dart
```

However, running a version, modified for accessibility testing breaks tests because layouts overflow: 

```
flutter test --dart-define=testFlavor=a11yTester
``` 

Modified version disables animations, enables bold text setting, requests high contrast theme and changes font scaler to 10.0. This value is unrealistically high just to demonstrate a possibility of finding issues when running existing widget tests with modified accessibility settings.
