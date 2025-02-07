import '../metadata.dart';
import './question_select.dart';

class QuestionRadiogroup extends QuestionSelect {
  static final description = {
    'type': 'radiogroup',
    'parent': 'questionselect',
    'properties': []
  };
  QuestionRadiogroup([dynamic json])
      : super(json, QuestionRadiogroup.description['type'].toString());

  @override
  registerObjectDescription() {
    super.registerObjectDescription();
    Metadata.registerObjectDescription(QuestionRadiogroup.description);
  }
}
