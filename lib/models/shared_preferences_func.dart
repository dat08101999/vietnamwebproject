import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPerferencesFunction {
  static var userinfo = 'user_information';
  SharedPreferences _sharedPreferences;
  static SharedPerferencesFunction _function;

  static SharedPerferencesFunction getIntance() {
    if (_function == null) {
      return new SharedPerferencesFunction();
    }
    return _function;
  }

  static void setData({@required key, @required value}) {
    getIntance()._setData(key, value);
  }

  void _setData(key, value) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(key, value);
  }

  Future<String> _getData(key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(key);
  }

  static Future<String> getData({@required key}) {
    return getIntance()._getData(key);
  }
}
