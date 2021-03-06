import 'dart:convert';

class Customer {
  int id;
  int customerID;
  String name;
  dynamic address;
  String phone;
  String email;
  int addedTime;
  String addedDate;
  Customer({
    this.id,
    this.customerID,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.addedTime,
    this.addedDate,
  });

  Customer copyWith({
    int id,
    int customerID,
    String name,
    dynamic address,
    String phone,
    String email,
    int addedTime,
    String addedDate,
  }) {
    return Customer(
      id: id ?? this.id,
      customerID: customerID ?? this.customerID,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      addedTime: addedTime ?? this.addedTime,
      addedDate: addedDate ?? this.addedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerID': customerID,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'addedTime': addedTime,
      'addedDate': addedDate,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      id: map['_id'],
      customerID: map['customer_id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      email: map['email'],
      addedTime: map['addedTime'],
      addedDate: map['addedDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, customerID: $customerID, name: $name, address: $address, phone: $phone, email: $email, addedTime: $addedTime, addedDate: $addedDate)';
  }
}
