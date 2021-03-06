import 'package:flutter_back_end/models/user_profile.dart';

class ConfigUser {
  UserProfile _userProfile;
  String _token;

  String get token => _token;

  set token(String token) {
    if (_token == null) _token = token;
  }

  UserProfile get userProfile => _userProfile;

  set userProfile(UserProfile userProfile) {
    if (_userProfile == null) _userProfile = userProfile;
  }
}
