import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:get/get.dart';

class ControllerCustomers extends GetxController {
  int _limit = 0;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController addressRecie = TextEditingController();
  Customer customer;
  int get limit => _limit;
  set limit(int limit) {
    _limit += limit;
    update();
  }

  getInfo(Customer customer) async {
    this.customer = customer;
    if (customer != null) {
      name.text = customer.name;
      email.text = customer.email;
      phone.text = customer.phone;
      addressRecie.text = customer.address;
      address.text = await ConfigsMywebvietnam.getAddress({
        'province': customer.province,
        'district': customer.district,
        'ward': customer.ward
      });
    }
    update();
  }

  textClear() {
    customer = Customer();
    name.text = '';
    email.text = '';
    phone.text = '';
    addressRecie.text = '';
    address.text = '';
  }
}

class ControllerMessage extends GetxController {
  bool isShow = false;
  showMessage() {
    isShow = true;
    update();
  }

  hideMessage() {
    isShow = false;
    update();
  }
}

class ControllerCheckBox extends GetxController {
  bool isShow = false;
  List<Customer> markedCustomers = List<Customer>();
  changeState() {
    isShow = !isShow;
    if (isShow == false) {
      markedCustomers.clear();
    }
    update();
  }

  deleteAll() {
    isShow = false;
    markedCustomers.clear();
    update();
  }

  addCustomers(Customer customer) {
    markedCustomers.add(customer);
  }

  chose() {
    update();
  }
}

class ControllerListCustomer extends GetxController {
  List<Customer> customers = List<Customer>();

  getAllCustomer() async {
    customers = await getCustomer(limit: _limit);
    update();
  }

  int _limit = 0;
  int get limit => _limit;
  set limit(int limit) {
    _limit += limit;
    getAllCustomer();
  }

  Future<List<Customer>> getCustomer({int limit = 0}) async {
    var paramas = {
      'token': ControllerMainPage.webToken,
      'limit': 7 + limit,
      'offset': 0
    };
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getCustomers, parames: paramas);
    if (response['success']) {
      List customers = response['data'];
      return List.generate(
          customers.length, (index) => Customer.fromMap(customers[index]));
    } else {
      print('lấy dữ liệu lỗi');
      return null;
    }
  }
}
