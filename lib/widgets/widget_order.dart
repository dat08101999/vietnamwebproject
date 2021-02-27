import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/widgets/widget_text_in_color.dart';

class WidgetOrder extends StatelessWidget {
  final Order order;
  WidgetOrder({this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: order.product[0]['thumbnail'] ??
                  'https://dongythienluong.com/wp-content/uploads/2017/10/san-pham-dong-y.png',
              placeholder: (context, string) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                );
              },
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextInColor(
                  text: order.id.toString(),
                  color: Colors.teal,
                  textStyle: TextStyle(fontSize: 12),
                ),
                Text(
                  order.addedDate,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  order.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // order.address is String
                //     ? Text(
                //         order.address,
                //         style: TextStyle(fontSize: 15),
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       )
                //     : Text('Map<String,dynamic>'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextInColor(
                  text: order.status is int
                      ? Order.getStatus(order.status)
                      : Order.getStatus(int.parse(order.status)),
                  color: Colors.blue[200],
                  textStyle: TextStyle(fontSize: 10),
                ),
                Text(
                  order.amount['payment'].toString() + ' đ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(order.channel ?? 'VAWAY'),
              ],
            )
          ],
        ),
      )),
    );
  }
}
