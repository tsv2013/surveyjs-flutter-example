import './question_select.dart';

class QuestionCheckbox extends QuestionSelect {
  static final description = {
    'type': 'checkbox',
    'properties': [
      'renderAs',
      'name',
      'title',
      'value',
      {"name": 'choices', "type": 'itemvalue[]'}
    ]
  };
  QuestionCheckbox([dynamic json])
      : super(json, QuestionCheckbox.description['type'].toString());
}
