class PropertyDescriptor {
  final String name;
  late final String type;

  PropertyDescriptor(this.name, {this.type = 'string'});
  PropertyDescriptor.fromDescription(this.name, dynamic jsonDescription) {
    type = jsonDescription != null ? jsonDescription['type'] : 'string';
  }
  PropertyDescriptor.fromJson(dynamic jsonDescription)
      : this.fromDescription(
            jsonDescription is String
                ? jsonDescription
                : jsonDescription['name'],
            jsonDescription is String ? null : jsonDescription);
}

class ObjectDescriptor {
  final String type;
  final _properties = <Symbol, PropertyDescriptor>{};

  ObjectDescriptor(this.type, dynamic jsonDescription) {
    for (var jsonPropertyDescription in jsonDescription['properties']) {
      var propertyDescriptor =
          PropertyDescriptor.fromJson(jsonPropertyDescription);
      _properties[Symbol(propertyDescriptor.name)] = propertyDescriptor;
    }
  }
  ObjectDescriptor.fromJson(dynamic jsonDescription)
      : this(jsonDescription['type'], jsonDescription);
  Map<Symbol, PropertyDescriptor> get properties => _properties;
}

class Metadata {
  static final _descriptors = <Symbol, ObjectDescriptor>{};

  static registerObject(ObjectDescriptor objDescriptor) {
    Metadata._descriptors[Symbol(objDescriptor.type)] = objDescriptor;
  }

  static ObjectDescriptor? findObjectDescriptor(String type) {
    return Metadata._descriptors[Symbol(type)];
  }

  static List<String>? getObjectPropertyNames(String type) {
    return Metadata._descriptors[Symbol(type)]?.properties.values
        .map((propertyDescriptor) => propertyDescriptor.name)
        .toList();
  }
}
