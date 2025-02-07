import 'metadata.dart';
import 'panel.dart';
import 'questions/question.dart';

class Survey extends Panel {
  static final description = {
    "type": "survey",
    'parent': 'panel',
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
