import 'package:flutter/material.dart';
import './panel.dart';
import '../survey.dart';

class SurveyWidget extends StatelessWidget {
  final Survey survey;
  const SurveyWidget(this.survey, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];
    if (survey.title != null) {
      content.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 32.0),
          child: Row(children: [
            Text(
              survey.title ?? '',
              style: const TextStyle(fontSize: 48),
            )
          ])));
    }
    content.add(PanelWidget(survey));
    content.add(Row(
      children: [
        TextButton.icon(
          onPressed: () {
            survey.setData({
              "question2": "answer1",
              "question3": "item1",
            });
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
    ));
    return Padding(
        padding: const EdgeInsets.all(32.0), child: Column(children: content));
  }
}
