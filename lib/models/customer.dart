import 'dart:convert';

import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class Customer {
  int id;
  String name;
  String address;
  String phone;
  String email;
  int province;
  int district;
  int ward;
  int addedtime;
  String addeddate;
  // bool block;
  Customer({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.province,
    this.district,
    this.ward,
    this.addedtime,
    this.addeddate,
    // this.block,
  });

  Customer copyWith({
    int id,
    String name,
    String address,
    String phone,
    String email,
    int province,
    int district,
    int ward,
    int addedtime,
    String addeddate,
    // bool block,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      addedtime: addedtime ?? this.addedtime,
      addeddate: addeddate ?? this.addeddate,
      //block: block ?? this.block,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'province': province,
      'district': district,
      'ward': ward,
      'added_time': addedtime,
      'added_date': addeddate,
      // 'block': block,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Customer(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      email: map['email'],
      province: map['province'],
      district: map['district'],
      ward: map['ward'],
      addedtime: map['added_time'],
      addeddate: map['added_date'],
      // block: map['block'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, address: $address, phone: $phone, email: $email, province: $province, district: $district, ward: $ward, added_time: $addedtime, added_date: $addeddate)';
  }


  static String requestError;

  static Future<Customer> infoOneCustomer(int customerId) async {
    Customer customer = Customer();
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getInfoCustomer + '/' + customerId.toString(),
        parames: {'token': ControllerMainPage.webToken});
    // response = json.decode(response);
    if (response['success']) {
      customer = Customer.fromMap(response['data'][0]);
      return customer;
    } else {
      print('failed');
      return null;
    }
  }

  static updateCustomer(Customer customer) async {
    try {
      var response = await RequestDio.postWithHeader(
          url: ConfigsMywebvietnam.getCustomers + '/' + customer.id.toString(),
          parameters: {
            'name': customer.name,
            'phone': customer.phone,
            'address': customer.address,
            'province': customer.province,
            'district': customer.district,
            'ward': customer.ward,
          },
          header: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie':
                'dbdad159c321a98161b40cc2ec4ba243=81c797dc5b7aecb557f090be5dd37a4254653cac'
          });
      if (response['success'] == true)
        return true;
      else {
        requestError = response['message'];
        print(requestError);
        return false;
      }
    } catch (ex, trace) {
      print(ex + trace);
      return false;
    }
  }

  static Future<bool> addCustomers(Customer customer) async {
    try {
      print(customer);
      var response = await RequestDio.postWithHeader(
          url: ConfigsMywebvietnam.getCustomers +
              '?token=' +
              ControllerMainPage.webToken,
          parameters: {
            'name': customer.name,
            'phone': customer.phone,
            'address': customer.address,
            'province': customer.province,
            'district': customer.district,
            'password': '',
            'ward': customer.ward,
            'block': ''
          },
          header: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie':
                'dbdad159c321a98161b40cc2ec4ba243=81c797dc5b7aecb557f090be5dd37a4254653cac'
          });
      if (response['success'] == true)
        return true;
      else {
        requestError = response['message'];
        print(requestError);
        return false;
      }
    } catch (ex, trace) {
      print(ex + trace);
      return false;
    }
  }
}
