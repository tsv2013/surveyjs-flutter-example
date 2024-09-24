import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/model_base.dart';

void main() {
  group('BsaeModel deserialization', () {
    test('Simple deserialization', () {
      var raw = '''{"type": "text", "value": "some string"}''';
      var jsonObj = json.decode(raw);
      var obj = ModelBase.fromJson(jsonObj);
      expect(obj.type, 'text');
      expect(obj['value'], null);
      obj = ModelBase.fromJson(jsonObj, ['value']);
      expect(obj.type, 'text');
      expect(obj['value'], 'some string');
    });
    test('Get/set methods', () {
      var obj = ModelBase();
      expect(obj.type, '');
      obj['value'] = 'some string';
      expect(obj['value'], 'some string');
      obj = ModelBase(type: 'some');
      expect(obj.type, 'some');
    });
  });
}
