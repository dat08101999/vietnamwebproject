import 'dart:convert';

import 'package:flutter/foundation.dart';

class Customer {
  int id;
  int customer_id;
  String name;
  Map<String, dynamic> address;
  String phone;
  String email;
  String message;
  int status;
  String discount;
  List<Map<String, dynamic>> product;
  int added_time;
  String added_date;
  int payment;
  String shipment;
  Map<String, dynamic> amount;
  Map<String, dynamic> timeline;
  List<Map<String, dynamic>> options;

  Customer({
    this.id,
    this.customer_id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.message,
    this.status,
    this.discount,
    this.product,
    this.added_time,
    this.added_date,
    this.payment,
    this.shipment,
    this.amount,
    this.timeline,
    this.options,
  });

  Customer copyWith({
    int id,
    int customer_id,
    String name,
    Map<String, dynamic> address,
    String phone,
    String email,
    String message,
    int status,
    String discount,
    List<Map<String, dynamic>> product,
    int added_time,
    String added_date,
    int payment,
    String shipment,
    Map<String, dynamic> amount,
    Map<String, dynamic> timeline,
    List<Map<String, dynamic>> options,
  }) {
    return Customer(
      id: id ?? this.id,
      customer_id: customer_id ?? this.customer_id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      message: message ?? this.message,
      status: status ?? this.status,
      discount: discount ?? this.discount,
      product: product ?? this.product,
      added_time: added_time ?? this.added_time,
      added_date: added_date ?? this.added_date,
      payment: payment ?? this.payment,
      shipment: shipment ?? this.shipment,
      amount: amount ?? this.amount,
      timeline: timeline ?? this.timeline,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customer_id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'message': message,
      'status': status,
      'discount': discount,
      'product': product,
      'added_time': added_time,
      'added_date': added_date,
      'payment': payment,
      'shipment': shipment,
      'amount': amount,
      'timeline': timeline,
      'options': options,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      id: map['_id'],
      customer_id: map['customer_id'],
      name: map['name'],
      address: Map<String, dynamic>.from(map['address']),
      phone: map['phone'],
      email: map['email'],
      message: map['message'],
      status: map['status'],
      discount: map['discount'],
      product: List<Map<String, dynamic>>.from(map['product']?.map((x) => x)),
      added_time: map['added_time'],
      added_date: map['added_date'],
      payment: map['payment'],
      shipment: map['shipment'],
      amount: Map<String, dynamic>.from(map['amount']),
      timeline: Map<String, dynamic>.from(map['timeline']),
      options: List<Map<String, dynamic>>.from(map['options']?.map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, customer_id: $customer_id, name: $name, address: $address, phone: $phone, email: $email, message: $message, status: $status, discount: $discount, product: $product, added_time: $added_time, added_date: $added_date, payment: $payment, shipment: $shipment, amount: $amount, timeline: $timeline, options: $options)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Customer &&
        o.id == id &&
        o.customer_id == customer_id &&
        o.name == name &&
        mapEquals(o.address, address) &&
        o.phone == phone &&
        o.email == email &&
        o.message == message &&
        o.status == status &&
        o.discount == discount &&
        listEquals(o.product, product) &&
        o.added_time == added_time &&
        o.added_date == added_date &&
        o.payment == payment &&
        o.shipment == shipment &&
        mapEquals(o.amount, amount) &&
        mapEquals(o.timeline, timeline) &&
        listEquals(o.options, options);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer_id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        message.hashCode ^
        status.hashCode ^
        discount.hashCode ^
        product.hashCode ^
        added_time.hashCode ^
        added_date.hashCode ^
        payment.hashCode ^
        shipment.hashCode ^
        amount.hashCode ^
        timeline.hashCode ^
        options.hashCode;
  }
}
