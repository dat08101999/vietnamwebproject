import 'dart:convert';

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
  });

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
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      name: map['name'],
      address: map['address'],
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(name: $name, address: $address, phone: $phone, email: $email, message: $message, status: $status, discount: $discount, product: $product, addedTime: $addedTime, addedDate: $addedDate, payment: $payment, shipment: $shipment, amount: $amount, channel: $channel, orderCode: $orderCode, id: $id)';
  }

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
}
