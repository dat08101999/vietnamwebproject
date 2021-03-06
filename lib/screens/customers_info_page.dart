import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/screens/address_page.dart';
import 'package:flutter_back_end/widgets/widget_button.dart';
import 'package:flutter_back_end/widgets/widget_textformfield.dart';
import 'package:get/get.dart';

class CustomerInfoPage extends StatefulWidget {
  final Customer customer;
  final String textSubMitButon;
  CustomerInfoPage({this.customer, this.textSubMitButon});
  @override
  _StateCustomerInfoPage createState() => _StateCustomerInfoPage(
      customer: customer, textSubMitButon: textSubMitButon);
}

class _StateCustomerInfoPage extends State<CustomerInfoPage> {
  @override
  void initState() {
    super.initState();
    controllerCustomers.getInfo(customer);
  }

  Customer customer;
  String textSubMitButon;
  TextEditingController password = TextEditingController();
  TextEditingController acceptpassword = TextEditingController();
  _StateCustomerInfoPage({this.customer, this.textSubMitButon});
  final ControllerCustomers controllerCustomers =
      Get.put(ControllerCustomers());
  ControllerPassword controllerPassword = Get.put(ControllerPassword());
  ControllerMessage _controllerMessage = Get.put(ControllerMessage());

  Widget buildListviewItem(String title, TextEditingController controller,
      {bool readonly = false, Function() ontap}) {
    return WidgetTextFormField(
        title: title,
        controller: controller,
        readonly: readonly,
        ontap: ontap,
        icon: Icon(Icons.edit));
  }

  // Widget buildPasswordArea() {
  //   return textSubMitButon == 'Thêm'
  //       ? Column(
  //           children: [
  //             Center(
  //               child: Text('Đặt Mật Khẩu'),
  //             ),
  //             buildItem(
  //               'Mật Khẩu',
  //               password,
  //               icon: IconButton(
  //                 onPressed: () {
  //                   controllerPassword.changeState();
  //                 },
  //                 icon: Icon(Icons.lock),
  //               ),
  //               isHide: controllerPassword.isHide,
  //             ),
  //             buildItem(
  //               'Nhập lại Mật Khẩu',
  //               acceptpassword,
  //               icon: IconButton(
  //                 icon: Icon(Icons.lock),
  //                 onPressed: () {},
  //               ),
  //               isHide: controllerPassword.isHide,
  //             )
  //           ],
  //         )
  //       : Container();
  // }

  // Widget buildButonSubmit() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5), color: Colors.blueAccent),
  //     margin: EdgeInsets.all(5),
  //     width: MediaQuery.of(context).size.width * 0.9,
  //     child: TextButton(
  //       onPressed: () async {
  //         Loading.show();
  //         _controllerMessage.hideMessage();
  //         bool result = await Customer.addCustomers(getCustomer());
  //         if (result == false) {
  //           _controllerMessage.showMessage();
  //         }
  //         Loading.dismiss();
  //       },
  //       child: Center(
  //         child: Text(
  //           textSubMitButon,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMessage() {
    return GetBuilder<ControllerMessage>(
      builder: (bulder) {
        if (_controllerMessage.isShow)
          return Center(
            child: Text(Customer.requestError),
          );
        return Container();
      },
    );
  }

  Customer getCustomer() {
    return Customer(
        name: controllerCustomers.name.text,
        phone: controllerCustomers.phone.text,
        address: controllerCustomers.addressRecie.text,
        email: controllerCustomers.email.text,
        district: controllerCustomers.customer.district,
        province: controllerCustomers.customer.province,
        ward: controllerCustomers.customer.ward);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(),
      body: GetBuilder<ControllerCustomers>(builder: (builder) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                ConfigsMywebvietnam.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(5),
                child: ListView(
                  children: [
                    buildMessage(),
                    buildListviewItem('Tên đầy đủ ', controllerCustomers.name),
                    buildListviewItem(
                        'Số điện thoại', controllerCustomers.phone),
                    buildListviewItem(
                        'Địa chỉ email ', controllerCustomers.email),
                    buildListviewItem(
                        'Địa chỉ nhận hàng', controllerCustomers.addressRecie),
                    buildListviewItem(
                        'Địa chỉ chi tiết', controllerCustomers.address,
                        readonly: true, ontap: () {
                      Get.to(AddressPage(
                        customer: controllerCustomers.customer,
                      ));
                    }),
                  ],
                ),
              ),
            ),
            ButtonCustom.buttonSubmit(
                name: textSubMitButon,
                onPress: () async {
                  Loading.show();
                  _controllerMessage.hideMessage();
                  bool result = await Customer.addCustomers(getCustomer());
                  if (result == false) {
                    _controllerMessage.showMessage();
                  }
                  Loading.dismiss();
                }),
          ],
        );
      }),
    );
  }
}
