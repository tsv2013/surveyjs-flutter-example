import 'package:flutter/material.dart';
import '../model_bloc.dart';
import '../metadata.dart';

class Question extends ModelBloc {
  static final description = {
    "type": "question",
    "properties": [
      'title',
      'value',
    ]
  };
  Question(dynamic json) : super.fromJson(json ?? {});
}

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Question',
        )
      ],
    );
  }
}

// Metadata.registerObjectDescription(Question.description);
