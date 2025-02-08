import 'dart:async';
import 'package:flutter/material.dart';
import '../questions/item_value.dart';
import '../questions/question_select.dart';

class CheckboxWidget extends StatelessWidget {
  final QuestionSelect questionSelect;
  const CheckboxWidget(this.questionSelect, {super.key});

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
                  // CheckboxListTile
                  child: Row(children: [
                    Checkbox(
                      tristate: true,
                      value: (snapshot.data ?? [])
                          .contains(itemValue.value.toString()),
                      onChanged: (bool? value) {
                        List<String>? qValue = questionSelect.value;
                        qValue ??= List<String>.empty(growable: true);
                        if (value ?? false) {
                          qValue.add(itemValue.value);
                        } else {
                          qValue.remove(itemValue.value);
                        }
                        questionSelect.value = qValue;
                      },
                    ),
                    Text(itemValue.text ?? '')
                  ]));
            }).toList(),
          );
        });
  }
}
