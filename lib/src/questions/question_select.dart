import './item_value.dart';
import './question.dart';

class QuestionSelect extends Question {
  static final description = {
    'type': 'questionselect',
    'properties': [
      'renderAs',
      'name',
      'title',
      'value',
      {"name": 'choices', "type": 'itemvalue[]'}
    ]
  };
  QuestionSelect([dynamic json, String? type])
      : super(json, type ?? QuestionSelect.description['type'].toString());
  @override
  add(String propertyName, [dynamic value]) {
    if (propertyName == 'choices') {
      var els = (value as List<dynamic>).map((el) => el as ItemValue).toList();
      super.add(propertyName, els);
    } else {
      super.add(propertyName, value);
    }
  }

  List<ItemValue> get choices {
    return get('choices');
  }

  set choices(List<ItemValue> choicesValue) {
    set('choices', choicesValue);
  }
}
