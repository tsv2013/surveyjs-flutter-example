import 'dart:async';

import 'metadata.dart';
import 'model_base.dart';

class ModelBloc extends ModelBase {
  final _notifiers = <Symbol, StreamController>{};

  ModelBloc.fromJson(dynamic json)
      : super.fromJson(json ?? {'type': 'modelbloc'},
            Metadata.findPropertyDescriptors(json?['type']));

  @override
  add(String propertyName, [dynamic value]) {
    super.add(propertyName, value);
    _notifiers[Symbol(propertyName)] = StreamController.broadcast();
  }

  @override
  set(String key, dynamic value) {
    super.set(key, value);
    getChangesStream(key).add(value);
  }

  getChangesStream(String propertyName) => _notifiers[Symbol(propertyName)];

  void dispose() {
    for (var stream in _notifiers.values) {
      stream.close();
    }
  }
}
