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

  static post({@required url, data, params}) async {
    data = FormData.fromMap(data);
    var response =
        await new Dio().post(url, data: data, queryParameters: params);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.data;
    } else {
      print('Post Error');
      return null;
    }
  }

  static postWithHeader(
      {@required url, data, parameters, @required header}) async {
    data = FormData.fromMap(data);
    var response = await new Dio().post(url,
        data: data,
        queryParameters: parameters,
        options: Options(headers: header));
    if (response.statusCode == 200 || response.statusCode == 400) {
      // print(response.request.uri);
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

  static delete({@required url, paramas}) async {
    var response = await new Dio()
        .delete(url, queryParameters: paramas, options: Options());
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('getWithOptions Error');
      return null;
    }
  }

  static deleteWitheader({@required url, paramas, @required header}) async {
    var response = await new Dio().delete(url,
        queryParameters: paramas, options: Options(headers: header));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print('getWithOptions Error');
      return null;
    }
  }
}
