import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool readonly;
  final Function() onTap;
  final Icon icon;
  final bool isHide;
  final int maxLine;
  final bool isNumberField;

  const WidgetTextFormField(
      {Key key,
      this.title,
      this.controller,
      this.readonly,
      this.onTap,
      this.icon,
      this.isHide,
      this.maxLine,
      this.isNumberField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isnumbertext = false;
    if (isNumberField != null) isnumbertext = isNumberField;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        keyboardType: isnumbertext ? TextInputType.number : TextInputType.text,
        maxLines: maxLine ?? 1,
        obscureText: isHide ?? false,
        onTap: onTap,
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
