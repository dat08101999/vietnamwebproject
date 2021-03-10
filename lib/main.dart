import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_theme.dart';
import 'package:flutter_back_end/configs/config_vaway.dart';
import 'package:flutter_back_end/models/shared_preferences_func.dart';
import 'package:flutter_back_end/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaid/VAID.dart';
import 'configs/config_user.dart';
import 'models/user_profile.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
BuildContext get currentContext => _navigatorKey.currentContext;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: ConfigTheme.backgroundColor,
          appBarTheme: AppBarTheme(
              color: ConfigTheme.primaryColor,
              centerTitle: true,
              elevation: 0,
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Launch());
  }
}

class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();
    getUserProfile();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (ConfigUser.userProfile == null) {
        _onload();
      } else {
        _gotoHomePage();
      }
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // decoration: BoxDecoration(color: Colors.blue[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.teal,
              maxRadius: 100,
            ),
            Text(
              'Chào mừng tới VAWAY-APP',
              style: TextStyle(color: Colors.white70, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  _onload() async {
    // kiểm tra đăng nhập, nếu chưa đăng nhập thì hiển thị popup VAID
    VAID.auth(
      context: context,
      appdata: {
        'id': ConfigsVAWAY.appId,
        'key': ConfigsVAWAY.key,
        'secret': ConfigsVAWAY.secret
      },
      callback: (response) async {
        if (response != null) {
          if (response['success'] = true) {
            SharedPerferencesFunction.setData(
                key: ConfigsVAWAY.keyUserInformation,
                value: json.encode(response['results']));
            ConfigUser.token = response['results']['token'];
            var profile = response['results']['profile'];
            ConfigUser.userProfile = UserProfile.fromMap(profile);
            _gotoHomePage();
          }
        }
      },
      enableClose: false,
    );
  }

  void getUserProfile() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var _dataUser =
        _sharedPreferences.getString(ConfigsVAWAY.keyUserInformation);
    if (_dataUser != null) {
      setState(() {
        var data = jsonDecode(_dataUser);
        //* khởi tạo thông tin ng dùng
        ConfigUser.token = data['token'];
        var profile = data['profile'];
        ConfigUser.userProfile = UserProfile.fromMap(profile);
      });
    }
  }
}

void _gotoHomePage() {
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    // Navigator.pushAndRemoveUntil(
    //     currentContext,
    //     MaterialPageRoute(builder: (context) => HomePage(name: username)),
    //     (route) => false);
    Get.off(() => HomePage());
    timer?.cancel();
  });
}
