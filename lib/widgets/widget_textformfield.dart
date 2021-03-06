import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool readonly;
  final Function() ontap;
  final Widget icon;
  final bool isHide;

  const WidgetTextFormField({
    Key key,
    this.title,
    this.controller,
    this.readonly,
    this.ontap,
    this.icon,
    this.isHide,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        maxLines: 1,
        obscureText: isHide ?? false,
        onTap: ontap,
        readOnly: readonly ?? false,
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          icon: icon,
          isDense: true, // Added this
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
