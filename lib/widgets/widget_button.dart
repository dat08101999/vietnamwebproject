import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCustom {
  static Widget buttonBorder(
      {@required String name,
      @required Color borderColor,
      @required Function onPress}) {
    return InkWell(
        onTap: onPress,
        child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              name ?? 'ButtonBorder',
              style: TextStyle(
                color: borderColor,
              ),
            )));
  }
}
