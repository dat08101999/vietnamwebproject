import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_user.dart';
import 'package:flutter_back_end/configs/config_vaway.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/shared_preferences_func.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonCustom.buttonSubmit(
            title: Text(
              'Đăng Xuất',
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onPress: () async {
              await SharedPerferencesFunction.deleteData(
                  ConfigsVAWAY.keyUserInformation);
              ConfigUser.token = null;
              ConfigUser.userProfile = null;
              Get.find<ControllerMainPage>().setTokenWeb(null);
              Get.offAll(Launch());
            },
          )
        ],
      ),
    );
  }
}
