import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_theme.dart';

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
        ),
      ),
    );
  }

  static Widget buttonSubmit(
      {@required Widget title, @required Function onPress, double width}) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ConfigTheme.primaryColor),
        margin: EdgeInsets.all(5),
        width: width,
        child: TextButton(
          onPressed: onPress,
          child: Center(child: title),
        ),
      ),
    );
  }
}
