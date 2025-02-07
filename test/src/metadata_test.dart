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
      expect(
          Metadata.findPropertyDescriptors('text')
              .map((pd) => pd.name)
              .toList(),
          ['strProperty', 'numProperty', 'boolProperty']);
      var propDescriptor =
          Metadata.findPropertyDescriptor('text', 'numProperty');
      expect(propDescriptor != null, true);
      expect(propDescriptor!.type, 'number');
    });
  });
  test('Collect parent properties', () {
    var jsonChildDescription = {
      "type": "child",
      "parent": "parent",
      "properties": [
        'strProperty',
      ]
    };
    var jsonParentDescription = {
      "type": "parent",
      "properties": [
        {"name": 'numProperty', "type": 'number'},
        {"name": 'boolProperty', "type": 'bool'}
      ]
    };
    Metadata.registerObjectDescription(jsonChildDescription);
    Metadata.registerObjectDescription(jsonParentDescription);
    expect(
        Metadata.findPropertyDescriptors('child').map((pd) => pd.name).toList(),
        ['strProperty', 'numProperty', 'boolProperty']);
  });
}
