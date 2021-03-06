import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:get/get.dart';

class WidgetCustomers extends StatelessWidget {
  final Customer customer;
  WidgetCustomers({this.customer});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
      child: InkWell(
        onTap: () {
          print(customer.id);
          Get.to(CustomerInfoPage(
            customer: customer,
            textSubMitButon: 'Cập nhật thông tin',
          ));
        },
        child: ListTile(
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.stack.imgur.com/5swJm.png'),
          ),
          title: Text(customer.name),
          subtitle: Text(customer.email + '/' + customer.phone),
        ),
      ),
    );
  }
}
