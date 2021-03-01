import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class SignInInfo {
  static getAllinfo() async {
    String token = '4779ce0e8eeb2de09fd04dd38c7d0526';
    var response = await RequestDio.postWithHeader(
        url: ConfigsMywebvietnam.signInApi,
        parameters: {
          "token": token
        },
        data: {
          "access_token": token,
        },
        header: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Cookie':
              'dbdad159c321a98161b40cc2ec4ba243=7ed77dd0a588cadef8bf650d4719b546a90cc1e5'
        });
    return response;
  }

  static String moneyFomat(String moneyValue) {
    String result = '';
    for (int i = moneyValue.length - 1; i >= 0; i - 3) {
      result += moneyValue[i] + moneyValue[i - 1] + moneyValue[i - 2];
    }
    return result;
  }
}
