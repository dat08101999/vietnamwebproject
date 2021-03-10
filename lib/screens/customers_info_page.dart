import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/models/show_toast.dart';
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
  ControllerMessage _controllerMessage = Get.put(ControllerMessage());

  Widget buildListviewItem(String title, TextEditingController controller,
      {bool readonly = false, Function() ontap}) {
    return WidgetTextFormField(
        title: title,
        controller: controller,
        readonly: readonly,
        onTap: ontap,
        icon: Icon(Icons.edit));
  }

  Widget buildMessage() {
    return GetBuilder<ControllerMessage>(
      builder: (bulder) {
        if (_controllerMessage.isShow)
          return Center(
            child: Text(
              Customer.requestError,
              style: TextStyle(color: Colors.red),
            ),
          );
        return Container();
      },
    );
  }

  Customer getCustomer() {
    return Customer(
        id: customer.id,
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
      appBar: AppBar(
        title: Text(customer.name != null ? customer.name : ''),
        centerTitle: true,
      ),
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
                  Customer tempCustomer = getCustomer();
                  Loading.show();
                  _controllerMessage.hideMessage();
                  bool result = textSubMitButon == 'Thêm'
                      ? await Customer.addCustomers(tempCustomer)
                      : await Customer.updateCustomer(tempCustomer);
                  if (result == false) {
                    _controllerMessage.showMessage();
                  }
                  Loading.dismiss();
                  if (result == true) {
                    ShowToast.show(
                        title: textSubMitButon == 'Thêm'
                            ? 'Thêm Thành Công'
                            : 'Cập Nhật Thành Công');
                  }
                }),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    try {
      Get.find<ControllerListCustomer>().getAllCustomer();
      Get.find<ControllerCheckBox>().deleteAll();
      super.dispose();
    } catch (ex, trace) {
      print(trace);
    }
  }
}
