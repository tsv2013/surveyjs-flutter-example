import 'dart:async';
import 'package:flutter/material.dart';
import '../questions/item_value.dart';
import '../questions/question_select.dart';

class RadioGroupWidget extends StatelessWidget {
  final QuestionSelect questionSelect;
  const RadioGroupWidget(this.questionSelect, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: (questionSelect.getChangesStreamController('value')
                as StreamController)
            .stream,
        initialData: questionSelect.value,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            children: questionSelect.choices.map<Widget>((ItemValue itemValue) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  // RadioListTile
                  child: Row(children: [
                    Radio(
                      groupValue: snapshot.data.toString(),
                      value: itemValue.value.toString(),
                      onChanged: (String? value) {
                        questionSelect.value = value;
                      },
                    ),
                    Text(itemValue.text ?? '')
                  ]));
            }).toList(),
          );
        });
  }
}
