import 'package:get/get.dart';

class ProductController extends GetxController {
  int _limit = 0;

  int get limit => _limit;

  set limit(int limit) {
    _limit = limit;
    update();
  }
}
