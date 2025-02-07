import 'metadata.dart';
import 'panel.dart';
import 'questions/question.dart';

class Survey extends Panel {
  static final description = {
    "type": "survey",
    'parent': 'panel',
    "properties": [
      {"name": 'pages', "type": 'panel[]'}
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
    if (propertyName == 'pages') {
      var els = (value as List<dynamic>).map((el) => el as Panel).toList();
      super.add(propertyName, els);
    } else {
      super.add(propertyName, value);
    }
  }

  List<Panel> get pages {
    return get('pages');
  }

  set pages(List<Panel> pagesValue) {
    set('pages', pagesValue);
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
}
