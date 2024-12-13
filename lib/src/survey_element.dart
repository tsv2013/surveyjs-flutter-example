import 'package:flutter/material.dart';
import './model_bloc.dart';
import './metadata.dart';

class SurveyElement extends ModelBloc {
  static final description = {
    'type': 'element',
    'properties': [
      'title',
    ]
  };
  SurveyElement([dynamic json])
      : super.fromJson(json ?? {'type': SurveyElement.description['type']});
  String? get title {
    return get('title');
  }

  set title(String? titleValue) {
    set('title', titleValue);
  }
}
