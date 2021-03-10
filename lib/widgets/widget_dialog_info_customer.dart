import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/acction_system.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';

class DialogInfoCustomer extends StatelessWidget {
  final Order order;

  const DialogInfoCustomer({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(ConfigsMywebvietnam.urlAvatarDefalut),
              maxRadius: 80,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                order.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Text(
              order.email != '' ? order.email : 'không có Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                order.phone ?? 'không có số điện thoại',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Text(
                    'Địa Chỉ',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      order.address ??
                          'không có địa chỉ hoặc địa chỉ không hợp lệ !',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Lưu ý của khách hàng :',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                  ),
                  Text(order.message ?? 'không có gì !')
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                order.phone != null
                    ? ButtonCustom.buttonBorder(
                        name: 'Gọi Điện',
                        borderColor: Colors.green,
                        onPress: () {
                          AcctionSystem.call(phoneNumber: order.phone);
                        })
                    : ButtonCustom.buttonBorder(
                        name: 'Gọi Điện',
                        borderColor: Colors.grey,
                        onPress: () {}),
                ButtonCustom.buttonBorder(
                    name: 'Cancel',
                    borderColor: Colors.red,
                    onPress: () {
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
