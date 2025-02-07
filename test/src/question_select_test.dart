import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/element_factory.dart';
import 'package:surveyjs_flutter_example/src/metadata.dart';
import 'package:surveyjs_flutter_example/src/questions/item_value.dart';
import 'package:surveyjs_flutter_example/src/questions/question_select.dart';

void main() {
  group('QuestionSelect', () {
    test('Deserialize choices', () {
      ElementFactory.register('itemvalue', ItemValue.new);
      var obj = QuestionSelect({
        'choices': [
          {'text': 'Choice 1', 'value': 'item1'},
          {'text': 'Choice 2', 'value': 'item2'}
        ]
      });
      var choices = obj['choices'] as List<dynamic>;
      // ignore: unnecessary_null_comparison
      expect(choices != null, true);
      expect(choices.length, 2);
      expect(choices[0].type, 'itemvalue');
      expect(choices[0].text, 'Choice 1');
    });
  });
}
