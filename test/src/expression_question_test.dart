import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/questions/expression_question.dart';

void main() {
  group('QuestionSelect', () {
    test('Deserialize expression', () {
      var obj = ExpressionQuestion({'expression': '1+1'});
      expect(obj.type, 'expression');
      expect(obj.expression, '1+1');
      expect(obj.ast, isNotNull);
      expect(obj.value, null);
    });
    test('Evaluate simple expression', () {
      var obj = ExpressionQuestion({'expression': '1+1'});
      expect(obj.value, null);
      obj.eval();
      expect(obj.value, 2.0);
    });
  });
}
