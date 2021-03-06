import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  static httpPost({headers, url, body}) async {
    headers = headers;
    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = body;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  static postWithHeader(
      {@required url, data, parameters, @required header}) async {
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

  static delete({@required url, paramas, @required header}) async {
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
