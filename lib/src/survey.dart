import 'package:flutter/material.dart';
import 'metadata.dart';
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
  Survey([super.json]);

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
    return Column(
      children: survey.elements.map<Widget>((SurveyElement element) {
        return WidgetFactory.create(element.type, [element]);
      }).toList(),
    );
  }
}
