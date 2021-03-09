import 'package:flutter_back_end/models/models_revenue.dart';
import 'package:flutter_back_end/models/models_signinInfo.dart';
import 'package:get/get.dart' show GetxController;

class ControllerMainPage extends GetxController {
  static String webToken;
  int oders = 0;
  bool oderIncrease = false;
  bool moneyIncrase = false;
  bool customerIncease = false;
  int customers = 0;
  int products = 0;
  int titlelabel = 0;
  int money = 0;
  var basic = '';
  String name = '';
  var info;
  var infoDashBoard;

  getInforMation() async {
    try {
      info = await SignInInfo.getAllinfo();
      if (info['success'] == true) {
        info = info['data'];
        if (webToken == null) {
          setTokenWeb(info[0]['token']);
          infoDashBoard = await SignInInfo.getReportInfo();
          getDashBoardInfo();
          name = info[0]['name'];
          basic = info[0]['plan']['expried'].toString();
          print(infoDashBoard);
          basic = Revenue.dateformat(formatTimestamp(int.parse(basic)));
          update();
        }
      }
    } catch (ex, trace) {
      print(ex + trace);
    }
  }

  getDashBoardInfo() {
    infoDashBoard = infoDashBoard['data'];
    oders = int.parse(infoDashBoard['orders']['count'].toString());
    products = infoDashBoard['products']['count'];
    money = infoDashBoard['money']['count'];
    customers = infoDashBoard['customers']['count'];
    oderIncrease = isDataIncrease(infoDashBoard['orders']['type'].toString());
    customerIncease =
        isDataIncrease(infoDashBoard['customers']['type'].toString());
    moneyIncrase = isDataIncrease(infoDashBoard['money']['type'].toString());
  }

  changeData(index) async {
    name = info[index]['name'];
    basic = info[index]['plan']['expried'].toString();
    basic = Revenue.dateformat(formatTimestamp(int.parse(basic)));
    setTokenWeb(info[index]['token']);
    infoDashBoard = await SignInInfo.getReportInfo();
    getDashBoardInfo();
    update();
  }

  bool isDataIncrease(type) {
    if (type == 'increase') {
      return true;
    } else {
      return false;
    }
  }

  DateTime formatTimestamp(timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toUtc();
  }

  setTokenWeb(token) {
    webToken = token;
  }
}
