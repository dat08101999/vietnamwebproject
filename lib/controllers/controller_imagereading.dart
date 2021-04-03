import 'package:get/get.dart';

class ControllerReadImage extends GetxController {
  List<String> imageLink = <String>[].obs;
  List<bool> imageisChose = <bool>[].obs;
  List<String> imageChosenLink = <String>[].obs;
  int limit = 21;
  int offset = 0;
  RxBool isLoad = false.obs;
  String a;
  int maxLenght = 0;
  bool isFull = false;
}
