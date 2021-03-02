import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:get/get.dart';

class WidgetCustomers extends StatelessWidget {
  final Customer customer;
  WidgetCustomers({this.customer});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(customer.id);
        Get.to(CustomerInfoPage(
          id: customer.id.toString(),
        ));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('https://i.stack.imgur.com/5swJm.png'),
        ),
        title: Text(customer.name),
        subtitle: Text(customer.email + '/' + customer.phone),
      ),
    );
  }
}
