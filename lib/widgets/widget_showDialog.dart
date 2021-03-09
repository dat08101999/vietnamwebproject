import 'package:flutter/material.dart';
import 'package:flutter_back_end/main.dart';
import 'package:get/get.dart';

class WidgetShowDialog {
  static dialogAccept(String title,
      {Function() cancelTap, void Function() acceptTap}) {
    showDialog(
      context: currentContext,
      child: AlertDialog(
        title: Text(title),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 50,
              color: Colors.green,
              icon: Icon(Icons.check_circle_outline_sharp),
              onPressed: acceptTap,
            ),
            IconButton(
              color: Colors.red,
              iconSize: 50,
              icon: Icon(Icons.highlight_remove_sharp),
              onPressed: cancelTap,
            )
          ],
        ),
      ),
    );
  }

  static dialogDetail(String title, String subtitle, {Function() cancelTap}) {
    showDialog(
      context: currentContext,
      child: AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          Center(
            child: IconButton(
              icon: Icon(Icons.check_circle_outline),
              onPressed: cancelTap,
            ),
          )
        ],
      ),
    );
  }

  ///show process bar depend on percent of task
  static showProcessBar(GetxController controller) {
    showDialog(
      barrierDismissible: false,
      context: currentContext,
      child: GetBuilder(
          init: controller,
          builder: (builder) {
            return AlertDialog(
              title: Text(builder.error ?? ''),
              content: LinearProgressIndicator(
                value: builder.value,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[200]),
              ),
            );
          }),
    );
  }
}
