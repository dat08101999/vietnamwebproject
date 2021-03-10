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
    var header = {
      'Cookie':
          'dbdad159c321a98161b40cc2ec4ba243=7ed77dd0a588cadef8bf650d4719b546a90cc1e5'
    };
    var url = ConfigsMywebvietnam.getDashboard;
    var response =
        await RequestDio.getWithHeader(header: header, url: url, paramas: {
      'token': ControllerMainPage.webToken,
      'from': Revenue.dateformat(
          DateTime(DateTime.now().year, DateTime.now().month, 1)),
      'to': Revenue.dateformat(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day))
    });
    return response;
  }
}
