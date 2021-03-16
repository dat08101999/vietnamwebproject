import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/format.dart';
import 'package:flutter_back_end/widgets/widget_text_in_color.dart';

class WidgetVariations extends StatelessWidget {
  final Map<String, dynamic> variation;

  const WidgetVariations({Key key, this.variation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Text(
                    variation['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Số lượng còn lại : ',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: variation['stock'].toString(),
                      style: TextStyle(color: Colors.black54))
                ])),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextInColor(
                text: variation['sku'] ?? 'không có SKU',
                color: Colors.green,
              ),
              Text(
                Format.moneyFormat(variation['price_sale'].toString()) + ' đ',
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ],
      ),
    );
  }
}
