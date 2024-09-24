import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:surveyjs_flutter_example/src/metadata.dart';

void main() {
  group('Metadata general', () {
    test('Define an object', () {
      var jsonDescription = {
        "type": "text",
        "properties": [
          'strProperty',
          {"name": 'numProperty', "type": 'number'},
          {"name": 'boolProperty', "type": 'bool'}
        ]
      };
      var objDescriptor = ObjectDescriptor.fromJson(jsonDescription);
      Metadata.registerObject(objDescriptor);
      expect(Metadata.getObjectPropertyNames('text'),
          ['strProperty', 'numProperty', 'boolProperty']);
    });
  });
}
