import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class Revenue {
  static Future<dynamic> getRevenueData(DateTime from, DateTime to) async {
    //var token = json.decode(await SharedPerferencesFunction.getData('').toString());
    var token = '4779ce0e8eeb2de09fd04dd38c7d0526';
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam().getRepostRevenue,
        parames: {
          "token": token,
          "from": dateformat(from),
          "to": dateformat(to)
        });
    return response;
  }

  static String dateformat(DateTime source) {
    return source.day.toString() +
        '/' +
        source.month.toString() +
        '/' +
        source.year.toString();
  }
}
