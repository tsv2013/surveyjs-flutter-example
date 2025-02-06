import 'package:flutter/material.dart';

import './question.dart';

class QuestionText extends Question {
  static final description = {
    'type': 'text',
    'properties': [
      'inputType',
      'renderAs',
      'name',
      'title',
      'value',
    ]
  };
  QuestionText([dynamic json, String? type])
      : super(json, type ?? QuestionText.description['type'].toString());

  dynamic get inputType {
    return get('inputType');
  }

  set inputType(dynamic newValue) {
    set('inputType', newValue);
  }

  @override
  String get renderAs {
    return super.renderAs;
  }

  getKeyboardType() {
    switch (inputType?.toString()) {
      case 'number':
        return TextInputType.number;
      case 'date':
      case 'time':
      case 'datetime-local':
        return TextInputType.datetime;
      case 'email':
        return TextInputType.emailAddress;
      case 'url':
        return TextInputType.url;
      case 'tel':
        return TextInputType.phone;
      // case 'password':
      //   return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }
}
