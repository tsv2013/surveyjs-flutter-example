import 'package:flutter/material.dart';
import 'model_bloc.dart';
import 'metadata.dart';
import 'widget_factory.dart';

class Survey extends ModelBloc {
  static final description = {
    "type": "survey",
    "properties": [
      'title',
    ]
  };
  Survey(dynamic json) : super.fromJson(json ?? {});
}

class SurveyWidget extends StatelessWidget {
  const SurveyWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: ['prop1', 'prop2'].map<Widget>((String propertyName) {
        return WidgetFactory.create(propertyName, {});
      }).toList(),
    );
  }
}

// Metadata.registerObjectDescription(Survey.description);
