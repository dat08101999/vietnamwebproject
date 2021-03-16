import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
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
    String email = customer.email ?? ' Không có email';
    return InkWell(
      onLongPress: () {
        Get.find<ControllerCheckBox>().changeState();
      },
      onTap: () {
        if (!Get.find<ControllerCheckBox>().isShow) {
          Get.to(CustomerInfoPage(
            customer: customer,
            textSubMitButon: 'Cập nhật thông tin',
          ));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(ConfigsMywebvietnam.urlAvatarDefalut),
          ),
          title: Text(
            customer.name,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            email != ''
                ? email + ' / ' + customer.phone.toString()
                : 'không có email /' + customer.phone.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
    checkBoxValue = false;
    for (Customer customertemp in _controllerCheckBox.markedCustomers) {
      if (customer.id.toString().trim() == customertemp.id.toString().trim()) {
        checkBoxValue = true;
      }
    }
    if (_controllerCheckBox.isShow) {
      return Checkbox(
        //tristate: true,
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
