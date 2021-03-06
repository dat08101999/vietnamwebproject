import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WidgetCustomers extends StatelessWidget {
  final Customer customer;
  bool _checkBoxValue = false;
  ControllerCheckBox _controllerCheckBox = Get.put(ControllerCheckBox());
  WidgetCustomers({this.customer});
  @override
  Widget build(BuildContext context) {
    print('here' + customer.toString());
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
      child: InkWell(onLongPress: () {
        Get.find<ControllerCheckBox>().changeState();
      }, onTap: () {
        Get.to(CustomerInfoPage(
          customer: customer,
          textSubMitButon: 'Cập nhật thông tin',
        ));
      }, child: GetBuilder<ControllerCheckBox>(
        builder: (builder) {
          return ListTile(
            tileColor: Colors.white,
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://i.stack.imgur.com/5swJm.png'),
            ),
            title: Text(customer.name),
            subtitle: Text(customer.email + '/' + customer.phone.toString()),
            trailing: checkBox(),
          );
        },
      )),
    );
  }

  Widget checkBox() {
    if (_controllerCheckBox.isShow) {
      return Checkbox(
        onChanged: (value) {
          _checkBoxValue = value;
          if (_checkBoxValue == true) {
            _controllerCheckBox.addCustomers(customer);
          } else {
            _controllerCheckBox.markedCustomers.remove(customer);
          }
          Get.find<ControllerCheckBox>().chose();
        },
        value: _checkBoxValue,
      );
    }
    return null;
  }
}
