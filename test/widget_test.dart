// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:surveyjs_flutter_example/main.dart';
import 'package:surveyjs_flutter_example/src/metadata.dart';
import 'package:surveyjs_flutter_example/src/questions/question.dart';
import 'package:surveyjs_flutter_example/src/survey.dart';
import 'package:surveyjs_flutter_example/src/survey_element.dart';

void main() {
  testWidgets('Basic rendering test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Metadata.registerObjectDescription(SurveyElement.description);
    Metadata.registerObjectDescription(Question.description);
    Metadata.registerObjectDescription(Survey.description);
    const json = {
      "type": "survey",
      "elements": [
        {"type": "question", "title": "Question 1"},
        {"type": "question", "title": "Another question title"},
      ]
    };
    var survey = Survey(json);
    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: SurveyWidget(survey))));

    // Verify that our counter starts at 0.
    expect(find.text('Question 1'), findsOneWidget);
    expect(find.text('Question 2'), findsNothing);
    expect(find.text('Another question title'), findsOneWidget);

    // TextFormField textFormField = tester.firstWidget(find.text('Question 1'));
    // tester.enterText(find.text('Question 1'), 'Answer 1');
    final textFormField =
        find.byType(TextFormField).evaluate().first.widget as TextFormField;
    expect(textFormField, isNotNull);
    // expect(textFormField.controller!.value.text, equals("Answer 1"));
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
