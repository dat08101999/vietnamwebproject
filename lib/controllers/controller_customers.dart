import 'package:flutter_back_end/models/customer.dart';
import 'package:get/get.dart';

class ControllerCustomers extends GetxController {
  int _limit = 0;

  int get limit => _limit;
  Customer customer = Customer();
  getCustomer(id) async {
    customer = await Customer.infoOneCustomer(int.parse(id));
  }

  set limit(int limit) {
    _limit += limit;
    update();
  }
}
