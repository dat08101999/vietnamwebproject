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
      province: map['province'] != null
          ? (map['province'] is int
              ? map['province']
              : int.parse(map['province']))
          : map['city'] is int
              ? map['city']
              : int.parse(map['city']),
      district:
          map['district'] is int ? map['district'] : int.parse(map['district']),
      ward: map['ward'] is int ? map['ward'] : int.parse(map['ward']),
      addedtime: map['added_time'],
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
  static upDateCustomer(Customer customer) async {
    try {
      requestError = '';
      var response = await RequestDio.post(
        url: ConfigsMywebvietnam.getCustomers +
            '/' +
            customer.id.toString() +
            '?token=' +
            ControllerMainPage.webToken,
        data: {
          'name': customer.name,
          'phone': customer.phone,
          'address': customer.address,
          'email': customer.email,
          'province': customer.province.toString(),
          'district': customer.district.toString(),
          'ward': customer.ward.toString(),
        },
      );
      if (response['success'] == true)
        return true;
      else {
        requestError = response['message'];
        return false;
      }
    } catch (ex, trace) {
      print(ex + trace);
      requestError = 'Xảy ra lỗi';
      return false;
    }
  }

  static Future<bool> addCustomers(Customer customer) async {
    try {
      requestError = '';
      var response = await RequestDio.post(
        url: ConfigsMywebvietnam.getCustomers +
            '?token=' +
            ControllerMainPage.webToken,
        data: {
          'name': customer.name,
          'phone': customer.phone,
          'address': customer.address,
          'email': customer.email,
          'province': customer.province.toString(),
          'district': customer.district.toString(),
          'ward': customer.ward.toString(),
        },
      );
      if (response['success'] == true)
        return true;
      else {
        requestError = response['message'];
        return false;
      }
    } catch (ex, trace) {
      print(ex + trace);
      requestError = 'Xảy ra lỗi';
      return false;
    }
  }

  static Future<bool> delete(int id) async {
    try {
      var response = await RequestDio.delete(
          url: ConfigsMywebvietnam.getCustomers + '/' + id.toString(),
          paramas: {'token': ControllerMainPage.webToken});
      if (response['success'] == true) {
        print(id.toString() + ' ' + response.toString() + ' ');
        return true;
      } else {
        return false;
      }
    } catch (ex, trace) {
      print(ex + trace);
      return false;
    }
  }
}
