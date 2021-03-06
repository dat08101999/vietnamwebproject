import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_vaway.dart';
import 'package:flutter_back_end/models/shared_preferences_func.dart';
import 'package:flutter_back_end/screens/HomePage.dart';
import 'package:get/get.dart';
import 'package:vaid/VAID.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Launch(),
    );
  }
}

class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      _onload();
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.blue[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            SizedBox(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  // goTo(currentContext, 'quang');
                },
                child: Text("Đi tới Trang Quản Lý"),
              ),
            )
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
                key: 'user_information', value: response.toString());
            _gotoHomePage(response['results']['profile']['name']);
          }
        }
      },
      enableClose: false,
    );
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