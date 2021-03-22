import 'package:get/get.dart' show GetxController;

class OrdersController extends GetxController {
  int _limit = 0;
  int status = 0;
  int purchase = 0;

  int get getStatus => this.status;

  set setStatus(int status) {
    this.status = status;
    update();
  }

  get getPurchase => this.purchase;

  set setPurchase(purchase) {
    this.purchase = purchase;
    update();
  }

  int get limit => _limit;

  set limit(int limit) {
    _limit += limit;
    update();
  }
}
