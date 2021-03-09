import 'package:get/get.dart';

class ControllerProcessBardelete extends GetxController {
  double value;
  String error = '';
  changevalue(newvalue) {
    value = newvalue;
    update();
  }

  seterror(error) {
    error += error + '\n';
    update();
  }

  clearerror() {
    error = '';
    update();
  }
}
