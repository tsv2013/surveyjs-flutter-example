import 'metadata.dart';
import 'panel.dart';
import 'questions/question.dart';
import 'survey_element.dart';

class Survey extends SurveyElement implements IPanel {
  static final description = {
    "type": "survey",
    'parent': 'element',
    "properties": [
      {"name": 'elements', "type": 'element[]'}
    ]
  };
  Survey([dynamic json]) : super(json, Survey.description['type'].toString());

  @override
  registerObjectDescription() {
    super.registerObjectDescription();
    Metadata.registerObjectDescription(Survey.description);
  }

  @override
  add(String propertyName, [dynamic value]) {
    if (propertyName == 'elements') {
      var els =
          (value as List<dynamic>).map((el) => el as SurveyElement).toList();
      super.add(propertyName, els);
    } else {
      super.add(propertyName, value);
    }
  }

  List<SurveyElement> get elements {
    return get('elements');
  }

  set elements(List<SurveyElement> elementsValue) {
    set('elements', elementsValue);
  }

  getData() {
    var data = <String, dynamic>{};
    for (var element in elements) {
      if (element is Question && element.value != null) {
        data[element.name] = element.value;
      }
    }
    return data;
  }

  void setData(Map<String, dynamic> data) {
    for (var element in elements) {
      if (element is Question && data.containsKey(element.name)) {
        element.value = data[element.name];
      }
    }
  }

  @override
  List<SurveyElement> getElements() {
    return elements;
  }
}
