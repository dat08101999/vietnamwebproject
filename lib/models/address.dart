import 'dart:convert';

class AddressProvince {
  String type;
  String name;
  String state;
  String postal;
  String id;

  AddressProvince({
    this.type,
    this.name,
    this.state,
    this.postal,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'state': state,
      'postal': postal,
      'id': id,
    };
  }

  factory AddressProvince.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AddressProvince(
      type: map['type'],
      name: map['name'],
      state: map['state'],
      postal: map['postal'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressProvince.fromJson(String source) =>
      AddressProvince.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressProvince(type: $type, name: $name, state: $state, postal: $postal, id: $id)';
  }
}
