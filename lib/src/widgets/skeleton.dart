import 'package:flutter/material.dart';
import '../survey_element.dart';

class SkeletonWidget extends StatelessWidget {
  final SurveyElement surveyElement;
  const SkeletonWidget(this.surveyElement, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
            decoration: InputDecoration(
                labelText: surveyElement.title ?? '',
                border: const OutlineInputBorder()))
      ],
    );
  }
}
