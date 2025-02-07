import '../metadata.dart';
import './question_select.dart';

class QuestionCheckbox extends QuestionSelect {
  static final description = {
    'type': 'checkbox',
    'parent': 'questionselect',
    'properties': []
  };
  QuestionCheckbox([dynamic json])
      : super(json, QuestionCheckbox.description['type'].toString());

  @override
  registerObjectDescription() {
    super.registerObjectDescription();
    Metadata.registerObjectDescription(QuestionCheckbox.description);
  }
}
