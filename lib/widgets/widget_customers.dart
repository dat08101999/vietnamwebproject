import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WidgetCustomers extends StatelessWidget {
  final Customer customer;
  bool checkBoxValue;
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
          subtitle: Text(customer.email + '/' + customer.phone.toString()),
          trailing: CheckBoxClass(
            customer: customer,
          ),
        ),
      ),
    );
  }
}

class CheckBoxClass extends StatefulWidget {
  final Customer customer;
  CheckBoxClass({this.customer});
  @override
  _CheckBoxClassState createState() => _CheckBoxClassState(customer: customer);
}

class _CheckBoxClassState extends State<CheckBoxClass> {
  final Customer customer;
  ControllerCheckBox _controllerCheckBox = Get.put(ControllerCheckBox());
  bool checkBoxValue = false;
  _CheckBoxClassState({this.customer});
  Widget checkBox() {
    for (Customer customert in _controllerCheckBox.markedCustomers) {
      if (customer.id.toString().trim() == customert.id.toString().trim()) {
        checkBoxValue = true;
      }
    }
    if (_controllerCheckBox.isShow) {
      return Checkbox(
        onChanged: (value) {
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
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 40,
        child: GetBuilder<ControllerCheckBox>(
          builder: (builder) {
            return checkBox();
          },
        ));
  }
}
