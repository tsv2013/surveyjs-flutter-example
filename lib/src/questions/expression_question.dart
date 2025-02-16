import '../expression/ast.dart';
import '../expression/parser.dart';
import '../metadata.dart';
import './question.dart';

class ExpressionQuestion extends Question {
  static final description = {
    'type': 'expression',
    'parent': 'question',
    'properties': [
      'expression',
    ]
  };
  ExpressionQuestion([dynamic json])
      : super(json, ExpressionQuestion.description['type'].toString());

  Expression? ast;

  @override
  registerObjectDescription() {
    super.registerObjectDescription();
    Metadata.registerObjectDescription(ExpressionQuestion.description);
  }

  @override
  add(String propertyName, [dynamic value]) {
    super.add(propertyName, value);
    if (propertyName == 'expression') {
      expression = value as String?;
    }
  }

  String? get expression {
    return get('expression');
  }

  set expression(String? newValue) {
    set('expression', newValue);
    ast = parser.parse(newValue ?? '').value;
  }

  void eval() {
    value = ast?.eval({});
  }
}
