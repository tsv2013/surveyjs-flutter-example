import '../survey_element.dart';

class Question extends SurveyElement {
  static final description = {
    'type': 'question',
    'properties': [
      'renderAs',
      'name',
      'title',
      'value',
    ]
  };
  Question([dynamic json, String? type])
      : super(json, type ?? Question.description['type'].toString());
  dynamic get name {
    return get('name');
  }

  set name(dynamic newName) {
    set('name', newName);
  }

  dynamic get value {
    return get('value');
  }

  set value(dynamic newValue) {
    set('value', newValue);
  }
}
