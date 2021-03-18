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
            )));
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

  static Widget buttonWithIcon(
      Color color, IconData icon, String text, Function() onTap) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
