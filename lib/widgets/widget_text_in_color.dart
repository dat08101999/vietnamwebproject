import 'package:flutter/material.dart';

class TextInColor extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle textStyle;

  const TextInColor({
    Key key,
    @required this.text,
    @required this.color,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
