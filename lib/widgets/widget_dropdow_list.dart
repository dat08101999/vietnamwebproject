import 'package:flutter/material.dart';

class WidgetDropdowList extends StatelessWidget {
  final dynamic firstValue;
  final List<dynamic> listValue;
  final Function onChanged;
  const WidgetDropdowList(
      {Key key,
      @required this.firstValue,
      @required this.listValue,
      @required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.archive_rounded,
                  size: 18,
                  color: Colors.black45,
                ),
              ),
              Text(
                'Danh Mục Sản Phẩm',
                style: TextStyle(),
              ),
            ],
          ),
          DropdownButton(
            value: firstValue.id,
            items: listValue
                .map((element) => DropdownMenuItem(
                      child: Text(
                        element.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: element.id,
                    ))
                .toList(),
            onChanged: onChanged,
            underline: Container(),
          ),
        ],
      ),
    );
  }
}
