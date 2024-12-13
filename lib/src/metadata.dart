class PropertyDescriptor {
  final String name;
  late final String type;
  late final bool isArray;
  late final bool isComplexType;

  PropertyDescriptor(this.name,
      {this.type = 'string', this.isArray = false, this.isComplexType = false});
  PropertyDescriptor.fromDescription(this.name, dynamic jsonDescription) {
    String declaredType =
        jsonDescription != null ? jsonDescription['type'] : 'string';
    if (declaredType.endsWith('[]')) {
      isArray = true;
      type = declaredType.substring(0, declaredType.length - 2);
    } else {
      isArray = false;
      type = declaredType;
    }
    isComplexType = !['string', 'bool', 'number'].contains(type);
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

  static registerObjectDescription(dynamic jsonDescription) {
    ObjectDescriptor objDescriptor = ObjectDescriptor.fromJson(jsonDescription);
    Metadata._descriptors[Symbol(objDescriptor.type)] = objDescriptor;
  }

  static ObjectDescriptor? findObjectDescriptor(String type) {
    return Metadata._descriptors[Symbol(type)];
  }

  static List<PropertyDescriptor> findPropertyDescriptors(String? type) {
    if (type == null) return [];
    return Metadata._descriptors[Symbol(type)]?.properties.values.toList() ??
        [];
  }

  static PropertyDescriptor? findPropertyDescriptor(
      String type, String propertyName) {
    return Metadata
        ._descriptors[Symbol(type)]?.properties[Symbol(propertyName)];
  }
}
