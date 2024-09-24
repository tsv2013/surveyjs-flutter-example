class ModelBase {
  late final String type;

  final _properties = <Symbol, String>{};
  final _values = <Symbol, dynamic>{};

  ModelBase({this.type = ''});

  ModelBase.fromJson(dynamic json, [List<String>? dynamicProperties]) {
    type = json['type'];
    assert(type != '', "Object type shouldn't be empty");

    if (dynamicProperties != null) {
      for (var propertyName in dynamicProperties) {
        add(propertyName, json[propertyName]);
      }
    }
  }

  dynamic get(String key) {
    assert(
        _values.containsKey(Symbol(key)), "Property should belong the object");
    return _values[Symbol(key)];
  }

  set(String key, dynamic value) {
    assert(
        _values.containsKey(Symbol(key)), "Property should belong the object");
    _values[Symbol(key)] = value;
  }

  dynamic operator [](String key) => get(key);
  operator []=(String key, dynamic value) => set(key, value);

  add(String propertyName, dynamic value) {
    _properties[Symbol(propertyName)] = propertyName;
    _values[Symbol(propertyName)] = value;
  }

  @override
  noSuchMethod(Invocation invocation) {
    return _values[invocation.memberName];
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    _properties.forEach(
        (symbol, propertyName) => json[propertyName] = _values[symbol]);
    return json;
  }
}
