import './question_select.dart';

class QuestionRadiogroup extends QuestionSelect {
  static final description = {
    'type': 'radiogroup',
    'properties': [
      'renderAs',
      'name',
      'title',
      'value',
      {"name": 'choices', "type": 'itemvalue[]'}
    ]
  };
  QuestionRadiogroup([dynamic json])
      : super(json, QuestionRadiogroup.description['type'].toString());
}
