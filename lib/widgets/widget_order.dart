import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/format.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/screens/oder_info_page.dart';
import 'package:flutter_back_end/widgets/widget_text_in_color.dart';
import 'package:get/get.dart';

class WidgetOrder extends StatelessWidget {
  final Order order;
  WidgetOrder({this.order});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderInfo(
              order: this.order,
            ));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          // boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.5),
          //   spreadRadius: 1,
          //   blurRadius: 3,
          //   offset: Offset(0, 3), // changes position of shadow
          // ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      //* id đơn hàng
                      TextInColor(
                        text: order.id.toString(),
                        color: Colors.teal,
                        textStyle: TextStyle(fontSize: 10, color: Colors.white),
                        width: 120,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // * trạng thái thanh toán
                      TextInColor(
                          text: order.timeline['purchased'] > 1
                              ? 'Đã thanh toán'
                              : "Chưa thanh toán",
                          textStyle:
                              TextStyle(fontSize: 10, color: Colors.black54),
                          color: order.timeline['purchased'] > 1
                              ? Colors.green[200]
                              : Colors.orange[200])
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Format.moneyFormat(order.amount['payment'].toString()),
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
      ),
    );
  }
}
