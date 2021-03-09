import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/show_toast.dart';

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
          TextButton(
              onPressed: () {
                ShowToast.show(title: 'OK');
              },
              child: Text('Chưa có cài đặt')),
        ],
      ),
    );
  }
}
