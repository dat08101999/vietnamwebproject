import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:get/get.dart';

// class WidgetCustomers extends StatefulWidget {
//   final Customer customer;
//   final bool checkBoxValue;
//   WidgetCustomers({this.customer, this.checkBoxValue});
//   @override
//   _WidgetCustomersState createState() =>
//       _WidgetCustomersState(checkBoxValue: checkBoxValue, customer: customer);
// }
// ignore: must_be_immutable
class WidgetCustomers extends StatelessWidget {
  final Customer customer;
  bool checkBoxValue;

  ControllerCheckBox _controllerCheckBox = Get.put(ControllerCheckBox());
  WidgetCustomers({this.customer, this.checkBoxValue});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
      child: InkWell(
        onLongPress: () {
          Get.find<ControllerCheckBox>().changeState();
          //Get.find<ControllerCheckBox>().deleteAll();
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
            checkBoxValue: checkBoxValue,
            customer: customer,
          ),
        ),
      ),
    );
  }

  Widget checkBox() {
    if (_controllerCheckBox.isShow) {
      return Checkbox(
        onChanged: (value) {
          checkBoxValue = value;
          if (checkBoxValue == true) {
            _controllerCheckBox.addCustomers(customer);
          } else {
            _controllerCheckBox.markedCustomers.remove(customer);
          }
          Get.find<ControllerCheckBox>().chose();
        },
        value: checkBoxValue,
      );
    }
    return null;
  }
}

class CheckBoxClass extends StatefulWidget {
  final bool checkBoxValue;
  final Customer customer;
  CheckBoxClass({this.checkBoxValue, this.customer});
  @override
  _CheckBoxClassState createState() =>
      _CheckBoxClassState(customer: customer, checkBoxValue: checkBoxValue);
}

class _CheckBoxClassState extends State<CheckBoxClass> {
  final Customer customer;
  ControllerCheckBox _controllerCheckBox = Get.put(ControllerCheckBox());
  bool checkBoxValue;
  _CheckBoxClassState({this.customer, this.checkBoxValue});
  Widget checkBox() {
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
    checkBoxValue = false;
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
