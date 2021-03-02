import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:get/get.dart';

class CustomerInfoPage extends StatelessWidget {
  final String id;
  CustomerInfoPage({this.id});
  ControllerCustomers _controllerCustomers = Get.put(ControllerCustomers());
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();

  Widget buildListviewItem(String title, TextField textField) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 50,
        color: Colors.white,
        child: ListTile(
          leading: Icon(Icons.headset_rounded),
          title: Text(title),
          subtitle: textField,
        ),
      ),
    );
  }

  Widget butonUpdate() {
    return FlatButton(
      onPressed: () {},
      child: Center(
        child: Text('Hoàn Tất'),
      ),
    );
  }

  getInfo() async {
    await _controllerCustomers.getCustomer(id);
    if (_controllerCustomers.customer != null) {
      _name.text = _controllerCustomers.customer.name;
      _email.text = _controllerCustomers.customer.email;
      _phone.text = _controllerCustomers.customer.phone;
      _address.text = '';
      _controllerCustomers.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(),
      body: GetBuilder<ControllerCustomers>(builder: (builder) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              buildListviewItem(
                  'Tên đầy đủ ',
                  TextField(
                    controller: _name,
                  )),
              buildListviewItem(
                  'Số điện thoại',
                  TextField(
                    style: TextStyle(decoration: TextDecoration.none),
                    controller: _phone,
                  )),
              buildListviewItem(
                  'Địa chỉ email ',
                  TextField(
                    controller: _email,
                  )),
              buildListviewItem(
                  'Địa chỉ chi tiết ',
                  TextField(
                    controller: _address,
                  )),
              butonUpdate()
            ],
          ),
        );
      }),
    );
  }
}
