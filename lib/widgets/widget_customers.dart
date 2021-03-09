import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WidgetCustomers extends StatelessWidget {
  final Customer customer;
  ControllerCheckBox _controllerCheckBox = Get.put(ControllerCheckBox());
  bool checkBoxValue = false;
  WidgetCustomers({this.customer, this.checkBoxValue});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
      child: InkWell(
        onLongPress: () {
          Get.find<ControllerCheckBox>().changeState();
        },
        onTap: () {
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
          subtitle: Text(customer.email +
              '/' +
              customer.phone.toString() +
              '' +
              customer.id.toString()),
          trailing: Container(
              height: 40,
              width: 40,
              child: GetBuilder<ControllerCheckBox>(
                builder: (builder) {
                  return checkBox();
                },
              )),
        ),
      ),
    );
  }

  Widget checkBox() {
    for (Customer customertemp in _controllerCheckBox.markedCustomers) {
      if (customer.id.toString().trim() == customertemp.id.toString().trim()) {
        checkBoxValue = true;
      }
    }
    if (_controllerCheckBox.isShow) {
      return Checkbox(
        onChanged: (value) {
          print(customer.id);
          checkBoxValue = value;
          if (checkBoxValue == true) {
            _controllerCheckBox.addCustomers(customer);
          } else {
            _controllerCheckBox.markedCustomers.remove(customer);
          }
          _controllerCheckBox.chose();
        },
        value: checkBoxValue,
      );
    }
    checkBoxValue = false;
    return Container();
  }
}
