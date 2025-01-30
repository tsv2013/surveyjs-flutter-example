import 'dart:async';

import 'package:flutter/material.dart';
import './item_value.dart';
import './question.dart';

class QuestionSelect extends Question {
  static final description = {
    'type': 'questionselect',
    'properties': [
      'name',
      'title',
      'value',
      {"name": 'choices', "type": 'itemvalue[]'}
    ]
  };
  QuestionSelect([dynamic json])
      : super(json, QuestionSelect.description['type'].toString());
  @override
  add(String propertyName, [dynamic value]) {
    if (propertyName == 'choices') {
      var els = (value as List<dynamic>).map((el) => el as ItemValue).toList();
      super.add(propertyName, els);
    } else {
      super.add(propertyName, value);
    }
  }

  List<ItemValue> get choices {
    return get('choices');
  }

  set choices(List<ItemValue> choicesValue) {
    set('choices', choicesValue);
  }
}

class QuestionSelectWidget extends StatelessWidget {
  final QuestionSelect questionSelect;
  const QuestionSelectWidget(this.questionSelect, {super.key});

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

// Metadata.registerObjectDescription(Question.description);
