import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_vaway.dart';
import 'package:flutter_back_end/models/shared_preferences_func.dart';
import 'package:flutter_back_end/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaid/VAID.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
BuildContext get currentContext => _navigatorKey.currentContext;

void main() {
  //print(SignInInfo.moneyFomat('3000'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
  var _userProfile;
  SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();
    getUserProfile();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (_userProfile == null) {
        _onload();
      } else {
        _userProfile = jsonDecode(_userProfile);
        _gotoHomePage(_userProfile['profile']['name']);
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
            _gotoHomePage(response['results']['profile']['name']);
          }
        }
      },
      enableClose: false,
    );
  }

  void getUserProfile() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var userProfile =
        _sharedPreferences.getString(ConfigsVAWAY.keyUserInformation);
    if (userProfile != null) {
      print(userProfile);
      setState(() {
        _userProfile = userProfile;
        //* khởi tạo thông tin ng dùng
      });
    }
  }
}

void _gotoHomePage(username) {
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    // Navigator.pushAndRemoveUntil(
    //     currentContext,
    //     MaterialPageRoute(builder: (context) => HomePage(name: username)),
    //     (route) => false);
    Get.off(() => HomePage(name: username));
    timer?.cancel();
  });
}
