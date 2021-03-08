import 'package:flutter/material.dart';

class WidgetDropdowList extends StatelessWidget {
  final dynamic fristValue;
  final List<dynamic> listValue;
  const WidgetDropdowList({Key key, this.fristValue, this.listValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: fristValue,
        items: listValue
            .map((element) => DropdownMenuItem(
                  child: Text(element.name),
                  value: element.id,
                ))
            .toList(),
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
