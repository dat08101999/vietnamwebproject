import 'package:get/get.dart';

class ControllerReadImage extends GetxController {
  List<String> imageLink = List<String>().obs;
  List<bool> imageisChose = List<bool>().obs;

  List<String> imageChosenLink = List<String>().obs;
  int limit = 21;
  int offset = 0;
  RxBool isLoad = false.obs;

  int maxLenght = 0;
  bool isFull = false;
}
