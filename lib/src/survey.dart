import 'package:flutter/material.dart';
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
}

class SurveyWidget extends StatelessWidget {
  final Survey survey;
  const SurveyWidget(this.survey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: survey.elements.map<Widget>((SurveyElement element) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                      child: Row(children: [Text(element.title ?? '')])),
                  WidgetFactory.create(element.type, [element])
                ]));
          }).toList(),
        ));
  }
}
