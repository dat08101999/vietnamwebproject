import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_theme.dart';
import 'package:flutter_back_end/main.dart';

class ButtonCustom {
  static Widget buttonBorder(
      {@required String name,
      @required Color borderColor,
      @required Function onPress}) {
    return InkWell(
        onTap: onPress,
        splashColor: borderColor,
        borderRadius: BorderRadius.circular(5),
        child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              name.toUpperCase() ?? 'ButtonBorder',
              style: TextStyle(color: borderColor, fontWeight: FontWeight.bold),
            )));
  }

  static Widget buttonSubmit(
      {@required String name, @required Function onPress}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ConfigTheme.primaryColor),
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(currentContext).size.width * 0.9,
      child: TextButton(
        onPressed: onPress,
        child: Center(
          child: Text(
            name.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
