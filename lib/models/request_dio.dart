import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RequestDio {
  static get({@required url, parames}) async {
    var response = await new Dio().get(url, queryParameters: parames);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('get Error');
      return null;
    }
  }

  static post({@required url, data}) async {
    var response = await new Dio().post(url, data: data);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.data;
    } else {
      print('Post Error');
      return null;
    }
  }

  static postWithHeader({@required url, data, @required header}) async {
    var response = await new Dio()
        .post(url, data: data, options: Options(headers: header));
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.data;
    } else {
      print('postWithHeader Error');
      return null;
    }
  }

  static getWithHeader({@required url, paramas, @required header}) async {
    var response = await new Dio()
        .get(url, queryParameters: paramas, options: Options(headers: header));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('getWithOptions Error');
      return null;
    }
  }
}
