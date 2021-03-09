import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_address.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/widgets/widget_showDialog.dart';
import 'package:get/get.dart';

class AddressPage extends StatefulWidget {
  final Customer customer;
  AddressPage({this.customer});
  @override
  _AddressPageState createState() => _AddressPageState(customer: customer);
}

class _AddressPageState extends State<AddressPage> {
  Customer customer;
  _AddressPageState({this.customer});
  ControllerAddressprovince controllerAddress =
      Get.put(ControllerAddressprovince());
  ControllerAddressdistrict controllerAddressdistrict =
      Get.put(ControllerAddressdistrict());
  ControllerWard controllerWard = Get.put(ControllerWard());
  @override
  void initState() {
    super.initState();
    getData();
  }

  buildBodyItem(String hintText,
      {items, dropvalue, Function(String value) onChange}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Row(children: [
          Icon(Icons.add_location_rounded),
          DropdownButton<String>(
            value: dropvalue,
            onChanged: onChange,
            icon: Container(
              child: Icon(Icons.keyboard_arrow_down_outlined),
            ),
            underline: Container(),
            items: items,
            hint: Text(hintText),
          ),
        ]),
      ),
    );
  }

  Widget buildButonDone() {
    return TextButton(
        onPressed: () async {
          customer = Customer();
          try {
            customer.province = int.parse(controllerAddress.provinceValue);
            customer.district =
                int.parse(controllerAddressdistrict.districtValue);
            customer.ward = int.parse(controllerWard.wardValue);
            Get.find<ControllerCustomers>().getInfo(customer);
            Get.back(
              result: customer,
            );
          } catch (ex) {
            WidgetShowDialog.dialogDetail(
                'Chưa chọn địa chỉ', 'Vui lòng chọn địa chỉ trước !',
                cancelTap: () {
              Navigator.pop(currentContext);
            });
          }
        },
        child: Text(
          'Xong',
          style: TextStyle(color: Colors.white),
        ));
  }

  getData() async {
    // Loading.show();
    await controllerAddress.getAllData();
    if (customer.province != null) {
      if (customer.province != 0 && customer.province != null) {
        controllerAddress.provinceValue = customer.province.toString();
        if (customer.district != 0 && customer.district != null) {
          await controllerAddressdistrict
              .getAllData(customer.province.toString());
          controllerAddressdistrict.changeData(customer.district.toString());
          if (customer.ward != 0) {
            // controllerWard.changeData(customer.ward.toString());
          }
        }
        controllerAddressdistrict.update();
      }
    }
    //Loading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chọn địa chỉ'),
        ),
        body: Stack(children: [
          ListView(
            children: [
              GetBuilder<ControllerWard>(builder: (builder) {
                return buildBodyItem('Chọn xã ',
                    items: controllerWard.wardItems,
                    dropvalue: controllerWard.wardValue,
                    onChange: controllerWard.changeData);
              }),
              GetBuilder<ControllerAddressdistrict>(builder: (builder) {
                return buildBodyItem('Chọn huyện',
                    items: controllerAddressdistrict.districtItems,
                    dropvalue: controllerAddressdistrict.districtValue,
                    onChange: controllerAddressdistrict.changeData);
              }),
              GetBuilder<ControllerAddressprovince>(builder: (builder) {
                return buildBodyItem('Chọn thành phố',
                    items: controllerAddress.provinceItems,
                    dropvalue: controllerAddress.provinceValue,
                    onChange: controllerAddress.changeData);
              }),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.blueAccent,
                  child: buildButonDone()),
            ),
          )
        ]));
  }
}
