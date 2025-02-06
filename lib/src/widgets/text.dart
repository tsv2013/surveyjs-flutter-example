import 'dart:async';
import 'package:flutter/material.dart';
import '../questions/question_text.dart';

class TextWidget extends StatelessWidget {
  final QuestionText question;
  const TextWidget(this.question, {super.key});

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
                  keyboardType: question.getKeyboardType(),
                  controller: controller,
                  onChanged: (value) => question.value = value,
                  decoration: const InputDecoration(
                      // labelText: question.title ?? '',
                      border: OutlineInputBorder()));
            })
      ],
    );
  }
}
