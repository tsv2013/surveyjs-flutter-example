import 'dart:async';
import 'package:flutter/material.dart';
import '../questions/item_value.dart';
import '../questions/question_select.dart';

class CheckboxWidget extends StatelessWidget {
  final QuestionSelect questionSelect;
  const CheckboxWidget(this.questionSelect, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: (questionSelect.getChangesStream('value') as StreamController)
            .stream,
        initialData: questionSelect.value,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            children: questionSelect.choices.map<Widget>((ItemValue itemValue) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  // CheckboxListTile
                  child: Row(children: [
                    Checkbox(
                      tristate: true,
                      value: snapshot.data.toString() ==
                          itemValue.value.toString(),
                      onChanged: (bool? value) {
                        questionSelect.value = itemValue.value;
                      },
                    ),
                    Text(itemValue.text ?? '')
                  ]));
            }).toList(),
          );
        });
  }
}
