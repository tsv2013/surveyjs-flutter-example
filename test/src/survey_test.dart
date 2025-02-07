import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/element_factory.dart';
import 'package:surveyjs_flutter_example/src/questions/question.dart';
import 'package:surveyjs_flutter_example/src/survey.dart';

void main() {
  setUp(() {
    ElementFactory.register('question', Question.new);
  });
  group('Survey deserialization', () {
    test('Simple deserialization', () {
      var raw =
          '''{"type": "survey", "elements": [{"type": "question", "title": "question1"}]}''';
      var jsonObj = json.decode(raw);
      var survey = Survey(jsonObj);
      expect(survey.type, 'survey');
      expect(survey.elements.length, 1);
      expect(survey.elements[0].type, 'question');
    });
  });
  group('Survey operation', () {
    test('getData/setData', () {
      var json = {
        "elements": [
          {"type": "question", "name": "question1"}
        ]
      };
      var survey = Survey(json);
      expect(survey.getData(), {});
      survey.setData({"question1": "answer1"});
      expect((survey.elements[0] as Question).value, "answer1");
      expect(survey.getData(), {"question1": "answer1"});
      (survey.elements[0] as Question).value = "answer2";
      expect(survey.getData(), {"question1": "answer2"});
    });
  });
}
