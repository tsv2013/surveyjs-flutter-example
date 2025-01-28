import './model_bloc.dart';

class SurveyElement extends ModelBloc {
  static final description = {
    'type': 'element',
    'properties': [
      'title',
    ]
  };
  SurveyElement([dynamic json, String? type])
      : super.fromJson(
            json, type ?? SurveyElement.description['type'].toString());
  String? get title {
    return get('title');
  }

  set title(String? titleValue) {
    set('title', titleValue);
  }
}
