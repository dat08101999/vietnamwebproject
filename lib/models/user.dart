import 'dart:convert';

import 'package:flutter_back_end/configs/config_vaway.dart';
import 'package:flutter_back_end/models/shared_preferences_func.dart';

class User {
  String token;
  String name;
  String id;
  String phone;
  String email;

  User({
    this.token,
    this.name,
    this.id,
    this.phone,
    this.email,
  });

  static getToken() async {
    var response = await SharedPerferencesFunction.getData(
            key: ConfigsVAWAY.keyUserInformation) ??
        'trống';
    var userProfile = jsonDecode(response);
    return userProfile['token'];
  }
}
