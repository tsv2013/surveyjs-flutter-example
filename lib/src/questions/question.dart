import 'package:flutter/material.dart';
import '../survey_element.dart';

class Question extends SurveyElement {
  static final description = {
    'type': 'question',
    'properties': [
      'title',
      'value',
    ]
  };
  Question([dynamic json])
      : super(json ?? {'type': Question.description['type']});
  dynamic get value {
    return get('value');
  }

  set value(dynamic newValue) {
    set('value', newValue);
  }
}

class QuestionWidget extends StatelessWidget {
  final SurveyElement surveyElement;
  const QuestionWidget(this.surveyElement, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
            decoration: InputDecoration(
                labelText: surveyElement.title ?? '',
                border: const OutlineInputBorder()))
      ],
    );
  }
}

// Metadata.registerObjectDescription(Question.description);
