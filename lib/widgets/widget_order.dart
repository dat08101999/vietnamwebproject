import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/widgets/widget_text_in_color.dart';

class WidgetOrder extends StatelessWidget {
  final Order order;
  WidgetOrder({this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* tên khách hàng
              Text(
                order.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //* địa chỉ
              Text(
                order.address,
                softWrap: true,
                style: TextStyle(fontSize: 10),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              //* id đơn hàng
              TextInColor(
                text: order.id.toString(),
                color: Colors.teal,
                textStyle: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //* trạng thái
              TextInColor(
                text: order.status is int
                    ? Order.getStatus(order.status)
                    : Order.getStatus(int.parse(order.status)),
                color: Order.getColorStatus(order.status is int
                    ? order.status
                    : int.parse(order.status)),
                textStyle: TextStyle(fontSize: 10, color: Colors.white70),
              ),
              //* giá tiền
              Text(
                order.amount['payment'].toString() + ' đ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //* kênh
              Text(
                order.channel.toUpperCase() ?? 'VAWAY',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
