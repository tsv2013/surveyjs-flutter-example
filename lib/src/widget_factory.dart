import 'package:flutter/material.dart';
import 'skeleton.dart';

class WidgetFactory {
  static final Map<String, dynamic> _widgets = {};
  static void register(String type, dynamic constructor) {
    _widgets[type] = constructor;
  }

  static Widget create(String type, Map<String, dynamic> arguments) {
    Map<Symbol, dynamic> args = arguments.map((k, v) => MapEntry(Symbol(k), v));
    var constructor = _widgets[type];
    return Function.apply(constructor ?? SkeletonWidget.new, [], args);
  }
}
