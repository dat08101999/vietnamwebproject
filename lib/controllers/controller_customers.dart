import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:get/get.dart' show GetxController;

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
    update();
  }

  addCustomers(Customer customer) {
    markedCustomers.add(customer);
  }

  chose() {
    update();
  }
}
