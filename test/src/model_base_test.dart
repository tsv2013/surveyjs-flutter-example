import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/metadata.dart';
import 'package:surveyjs_flutter_example/src/model_base.dart';
import 'package:surveyjs_flutter_example/src/survey_element.dart';

void main() {
  group('BsaeModel', () {
    test('Simple deserialization', () {
      var raw = '''{"type": "text", "value": "some string"}''';
      var jsonObj = json.decode(raw);
      var obj = ModelBase.fromJson(jsonObj);
      expect(obj.type, 'text');
      expect(() => obj['value'], throwsA(const TypeMatcher<AssertionError>()));
      Metadata.registerObjectDescription({
        'type': 'text',
        "properties": [
          {"name": 'value', "type": 'string'}
        ]
      });
      obj = ModelBase.fromJson(jsonObj);
      expect(obj.type, 'text');
      expect(obj['value'], 'some string');
      obj = ModelBase.fromJson({'value': 'some string'}, 'text');
      expect(obj.type, 'text');
      expect(obj['value'], 'some string');
    });
    test('Get/set methods', () {
      var obj = ModelBase();
      expect(obj.type, '');
      obj.add('value');
      obj['value'] = 'some string';
      expect(obj['value'], 'some string');
      obj = ModelBase(type: 'some');
      expect(obj.type, 'some');
    });
    test('Deserialize array', () {
      Metadata.registerObjectDescription({
        'type': 'custom',
        "properties": [
          {"name": 'elements', "type": 'element[]'}
        ]
      });
      var obj = ModelBase.fromJson({
        'type': 'custom',
        'elements': [
          {'type': 'element', 'title': 'Title'}
        ]
      });
      var elements = obj['elements'] as List<dynamic>;
      // ignore: unnecessary_null_comparison
      expect(elements != null, true);
      expect(elements.length, 1);
      expect(elements[0].type, 'element');
      expect(elements[0].title, 'Title');
    });
  });
}
