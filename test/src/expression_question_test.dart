import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/element_factory.dart';
import 'package:surveyjs_flutter_example/src/expression_context.dart';
import 'package:surveyjs_flutter_example/src/questions/expression_question.dart';
import 'package:surveyjs_flutter_example/src/questions/question.dart';
import 'package:surveyjs_flutter_example/src/survey.dart';

class TestExpressionContextProvider implements IExpressionContextProvider {
  @override
  Map<String, dynamic> getVariables() {
    return variables;
  }

  Map<String, dynamic> variables = {};
}

void main() {
  setUp(() {
    ElementFactory.register('question', Question.new);
    ElementFactory.register('expression', ExpressionQuestion.new);
  });
  group('QuestionSelect', () {
    test('Deserialize expression', () {
      var q = ExpressionQuestion({'expression': '1+1'});
      expect(q.type, 'expression');
      expect(q.expression, '1+1');
      expect(q.ast, isNotNull);
      expect(q.value, null);
    });
    test('Evaluate simple expression', () {
      var q = ExpressionQuestion({'expression': '1+1'});
      expect(q.value, null);
      q.eval();
      expect(q.value, 2.0);
    });
    test('Reference another question through context provider', () {
      var q = ExpressionQuestion({'expression': 'q1'});
      expect(q.value, null);
      expect(() => {q.eval(), true}, throwsArgumentError);
      TestExpressionContextProvider contextProvider =
          TestExpressionContextProvider();
      q.getContextProvider = () => contextProvider;
      contextProvider.variables['q1'] = 42;
      q.eval();
      expect(q.value, 42);
    });
    test('Reference another question in survey', () {
      var json = {
        "elements": [
          {"type": "question", "name": "question1"},
          {
            "type": "expression",
            "name": "question2",
            "expression": "{question1}"
          }
        ]
      };
      var survey = Survey(json);
      var q1 = survey.getQuestionByName('question1') as Question;
      var q2 = survey.getQuestionByName('question2') as ExpressionQuestion;
      expect(q1.value, null);
      expect(q2.value, null);
      q1.value = 42;
      expect(q1.value, 42);
      expect(q2.value, null);
      q2.eval();
      expect(q1.value, 42);
      expect(q2.value, 42);
    });
  });
}
