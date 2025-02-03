import 'dart:async';
import 'package:flutter/material.dart';
import '../questions/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  const QuestionWidget(this.question, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream:
                (question.getChangesStream('value') as StreamController).stream,
            initialData: question.value,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var controller = TextEditingController();
              controller.text =
                  question.value != null ? question.value.toString() : "";
              return TextFormField(
                  controller: controller,
                  onChanged: (value) => question.value = value,
                  decoration: InputDecoration(
                      labelText: question.title ?? '',
                      border: const OutlineInputBorder()));
            })
      ],
    );
  }
}
