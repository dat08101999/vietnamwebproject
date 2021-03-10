import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_back_end/models/customer.dart';

class Order {
  String name;
  dynamic address;
  String phone;
  String email;
  String message;
  dynamic status;
  dynamic discount;
  List<Map<String, dynamic>> product;
  int addedTime;
  String addedDate;
  dynamic payment;
  String shipment;
  Map<String, dynamic> amount;
  String channel;
  String orderCode;
  int id;
  // Customer customer;
  Map<String, dynamic> timeline;
  Order({
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
    this.channel,
    this.orderCode,
    this.id,
    // this.customer,
    this.timeline,
  });

  static String getStatus(int index) {
    List _statusOrder = [
      'Đang Chờ Duyệt',
      'Đã Xác Nhận',
      'Đang Vận Chuyển',
      'Đơn Hàng Bị Hủy',
      'Đơn Hàng Hoàn Tất'
    ];
    return _statusOrder[index];
  }

  static Color getColorStatus(int index) {
    List _colors = [
      Colors.blueGrey[400],
      Colors.orange[500],
      Colors.blue[400],
      Colors.red[400],
      Colors.green[600],
    ];
    return _colors[index];
  }

  Order copyWith({
    String name,
    dynamic address,
    String phone,
    String email,
    String message,
    dynamic status,
    dynamic discount,
    List<Map<String, dynamic>> product,
    int addedTime,
    String addedDate,
    dynamic payment,
    String shipment,
    Map<String, dynamic> amount,
    String channel,
    String orderCode,
    int id,
    Customer customer,
    Map<String, dynamic> timeline,
  }) {
    return Order(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      message: message ?? this.message,
      status: status ?? this.status,
      discount: discount ?? this.discount,
      product: product ?? this.product,
      addedTime: addedTime ?? this.addedTime,
      addedDate: addedDate ?? this.addedDate,
      payment: payment ?? this.payment,
      shipment: shipment ?? this.shipment,
      amount: amount ?? this.amount,
      channel: channel ?? this.channel,
      orderCode: orderCode ?? this.orderCode,
      id: id ?? this.id,
      // customer: customer ?? this.customer,
      timeline: timeline ?? this.timeline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'message': message,
      'status': status,
      'discount': discount,
      'product': product,
      'addedTime': addedTime,
      'addedDate': addedDate,
      'payment': payment,
      'shipment': shipment,
      'amount': amount,
      'channel': channel,
      'orderCode': orderCode,
      'id': id,
      // 'customer': customer?.toMap(),
      'timeline': timeline,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      name: map['name'],
      address: map['address'] is String
          ? map['address']
          : 'không có địa chỉ hoặc địa chỉ không hợp lệ',
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
      channel: map['channel'],
      orderCode: map['order_code'],
      id: map['id'],
      // customer: Customer.fromMap(map['customer']),
      timeline: Map<String, dynamic>.from(map['timeline']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(name: $name, address: $address, phone: $phone, email: $email, message: $message, status: $status, discount: $discount, product: $product, addedTime: $addedTime, addedDate: $addedDate, payment: $payment, shipment: $shipment, amount: $amount, channel: $channel, orderCode: $orderCode, id: $id, timeline: $timeline)';
  }
}
