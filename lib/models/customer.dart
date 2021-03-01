import 'dart:convert';

class Customer {
  int id;
  int customerID;
  String name;
  Map<String, dynamic> address;
  String phone;
  String email;
  String message;
  int status;
  String discount;
  List<Map<String, dynamic>> product;
  int addedTime;
  String addedDate;
  int payment;
  String shipment;
  Map<String, dynamic> amount;
  Map<String, dynamic> timeline;
  List<Map<String, dynamic>> options;

  Customer({
    this.id,
    this.customerID,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.message,
    this.status,
    this.discount,
    this.product,
    this.addedTime,
    this.addedDate,
    this.payment,
    this.shipment,
    this.amount,
    this.timeline,
    this.options,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerID,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'message': message,
      'status': status,
      'discount': discount,
      'product': product,
      'added_time': addedTime,
      'added_date': addedDate,
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
      customerID: map['customer_id'],
      name: map['name'],
      address: Map<String, dynamic>.from(map['address']),
      phone: map['phone'],
      email: map['email'],
      message: map['message'],
      status: map['status'],
      discount: map['discount'],
      product: List<Map<String, dynamic>>.from(map['product']?.map((x) => x)),
      addedTime: map['added_time'],
      addedDate: map['added_date'],
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
    return 'Customer(id: $id, customer_id: $customerID, name: $name, address: $address, phone: $phone, email: $email, message: $message, status: $status, discount: $discount, product: $product, added_time: $addedTime, added_date: $addedDate, payment: $payment, shipment: $shipment, amount: $amount, timeline: $timeline, options: $options)';
  }
}
