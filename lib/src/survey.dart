import 'package:flutter/material.dart';
import 'questions/question.dart';
import 'survey_element.dart';
import 'widget_factory.dart';

class Survey extends SurveyElement {
  static final description = {
    "type": "survey",
    "properties": [
      'title',
      {"name": 'elements', "type": 'element[]'}
    ]
  };
  Survey([dynamic json]) : super(json, Survey.description['type'].toString());

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
}

class SurveyWidget extends StatelessWidget {
  final Survey survey;
  const SurveyWidget(this.survey, {super.key});

  @override
  Widget build(BuildContext context) {
    var elements = survey.elements.map<Widget>((SurveyElement element) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                child: Row(children: [Text(element.title ?? '')])),
            WidgetFactory.create(element.type, [element])
          ]));
    }).toList();
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(children: [
          ...elements,
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  (survey.elements[0] as Question).value = "Test";
                },
                icon: const Icon(Icons.data_array),
                label: const Text('Set data'),
                iconAlignment: IconAlignment.start,
              ),
              TextButton.icon(
                onPressed: () {
                  var data = survey.getData();
                },
                icon: const Icon(Icons.flight_takeoff),
                label: const Text('Complete'),
                iconAlignment: IconAlignment.start,
              )
            ],
          )
        ]));
  }
}
