import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/models/loading.dart';
import 'package:flutter_back_end/screens/address_page.dart';
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

  Widget buildItem(String title, TextEditingController controller,
      {bool readonly = false,
      Function() ontap,
      Widget icon,
      bool isHide = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[200],
        child: TextFormField(
          obscureText: isHide,
          onTap: ontap,
          readOnly: readonly,
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            icon: icon,
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(8),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildListviewItem(String title, TextEditingController controller,
      {bool readonly = false, Function() ontap}) {
    return buildItem(title, controller,
        readonly: readonly, ontap: ontap, icon: Icon(Icons.headset));
  }

  Widget buildButonSubmit() {
    return TextButton(
      onPressed: () async {
        Customer tempCustomer = getCustomer();
        Loading.show();
        _controllerMessage.hideMessage();
        bool result = textSubMitButon == 'Thêm'
            ? await Customer.addCustomers(tempCustomer)
            : await Customer.upDateCustomer(tempCustomer);
        if (result == false) {
          _controllerMessage.showMessage();
        }
        Loading.dismiss();
        if (result == true) {
          print(controllerCustomers.email.text);
          Get.snackbar(
              '',
              textSubMitButon == 'Thêm'
                  ? 'Thêm Thành Công'
                  : 'Cập Nhật Thành Công',
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
      },
      child: Center(
        child: Text(
          textSubMitButon,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

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
      appBar: AppBar(),
      body: GetBuilder<ControllerCustomers>(builder: (builder) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(children: [
            Container(
              color: Colors.white,
              child: ListView(
                children: [
                  buildMessage(),
                  buildListviewItem('Tên đầy đủ ', controllerCustomers.name),
                  buildListviewItem('Số điện thoại', controllerCustomers.phone),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.blueAccent,
                    child: buildButonSubmit()),
              ),
            )
          ]),
        );
      }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<ControllerCustomers>().update();
  }
}
