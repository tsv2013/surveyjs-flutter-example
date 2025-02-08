import 'dart:async';
import 'package:flutter/material.dart';
import '../questions/question_text.dart';

class TextWidget extends StatelessWidget {
  final QuestionText question;
  final controller = TextEditingController();
  TextWidget(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: question.value,
        stream:
            (question.getChangesStreamController('value') as StreamController)
                .stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          controller.value = controller.value.copyWith(text: snapshot.data);
          return TextFormField(
              keyboardType: question.getKeyboardType(),
              controller: controller,
              onChanged: (value) => question.value = value,
              decoration: const InputDecoration(
                  // labelText: question.title ?? '',
                  border: OutlineInputBorder()));
        });
  }
}
