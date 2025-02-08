import 'dart:async';
import 'package:flutter/material.dart';
import './panel.dart';
import '../survey.dart';

class SurveyWidget extends StatelessWidget {
  final Survey survey;
  const SurveyWidget(this.survey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: survey.title != null
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(survey.title!),
              actions: [
                IconButton(
                  onPressed: () {
                    survey.setData({
                      "question2": "answer1",
                      "question3": "item1",
                    });
                  },
                  icon: const Icon(Icons.data_array),
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: StreamBuilder(
                  stream: (survey.getChangesStream('currentPage')
                          as StreamController)
                      .stream,
                  initialData: survey.currentPage,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return PanelWidget(survey.currentPage);
                  }))),
      bottomNavigationBar: StreamBuilder(
          stream: (survey.getChangesStream('currentPage') as StreamController)
              .stream,
          initialData: survey.currentPage,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: getNavigationActions(),
                ));
          }),
    );
  }

  getNavigationActions() {
    List<Widget> actions = [];
    if (!survey.isFirstPage) {
      actions.add(TextButton.icon(
        onPressed: () {
          survey.goPreviousPage();
        },
        icon: const Icon(Icons.skip_previous),
        label: const Text('Prevoius'),
        iconAlignment: IconAlignment.start,
      ));
    }
    actions.add(const Spacer());
    actions.add(survey.isLastPage
        ? TextButton.icon(
            onPressed: () {
              survey.complete();
            },
            icon: const Icon(Icons.check_circle),
            label: const Text('Complete'),
            iconAlignment: IconAlignment.start,
          )
        : TextButton.icon(
            onPressed: () {
              survey.goNextPage();
            },
            icon: const Icon(Icons.skip_next),
            label: const Text('Next'),
            iconAlignment: IconAlignment.end,
          ));
    return actions;
  }
}
