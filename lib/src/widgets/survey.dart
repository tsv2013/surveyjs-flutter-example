import 'package:flutter/material.dart';
import '../questions/question.dart';
import '../survey.dart';
import '../survey_element.dart';
import '../widget_factory.dart';

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
