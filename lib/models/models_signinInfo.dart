import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/configs/config_user.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/models_revenue.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class SignInInfo {
  static getAllinfo() async {
    String accesstoken = ConfigUser.token;
    print(accesstoken);
    var response = await RequestDio.post(
        url: ConfigsMywebvietnam.signInApi,
        data: {'access_token': accesstoken});
    return response;
  }

  static getReportInfo() async {
    var url = ConfigsMywebvietnam.getDashboard;
    var response = await RequestDio.get(url: url, parames: {
      'token': ControllerMainPage.webToken,
      'from': Revenue.dateformat(
          DateTime(DateTime.now().year, DateTime.now().month, 1)),
      'to': Revenue.dateformat(DateTime(
          DateTime.now().year, DateTime.now().month, endThisMonth().day))
    });
    return response;
  }

  static DateTime endThisMonth() {
    DateTime now = DateTime.now();
    int lastday = DateTime(now.year, now.month + 1, 0).day;
    return DateTime(now.year, now.month, lastday);
  }
}
