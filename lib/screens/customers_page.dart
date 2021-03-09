import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/controllers/controller_processbar.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:flutter_back_end/widgets/widget_customers.dart';
import 'package:flutter_back_end/widgets/widget_showDialog.dart';
import 'package:get/get.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  ControllerCustomers controllerCustomers = Get.put(ControllerCustomers());
  ControllerProcessBardelete _controllerProcessBardelete =
      Get.put(ControllerProcessBardelete());
  ControllerListCustomer _controllerListCustomer =
      Get.put(ControllerListCustomer());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerCustomers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerListCustomer.getAllCustomer();
    return Scaffold(
      appBar: AppBar(
        actions: [buildbuttonAdd()],
        title: Text('Khách hàng'),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ctlScroll) {
              if (ctlScroll is ScrollEndNotification) {
                if (ctlScroll.metrics.pixels ==
                    ctlScroll.metrics.maxScrollExtent) {
                  if (_controllerListCustomer.limit < 80) {
                    _controllerListCustomer.limit = 10;
                  }
                }
                return true;
              }
              return false;
            },
            child: _buildBlogs(),
          )),
    );
  }

  Widget buildbuttonAdd() {
    return IconButton(
      onPressed: () {
        Get.find<ControllerCustomers>().textClear();
        Get.to(CustomerInfoPage(
          customer: new Customer(),
          textSubMitButon: 'Thêm',
        ));
      },
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  List<Widget> customerLisst() {
    List<Widget> list = List<Widget>();
    for (Customer customer in _controllerListCustomer.customers) {
      list.add(WidgetCustomers(
        customer: customer,
      ));
    }
    return list;
  }

  Widget _buildBlogs() {
    return Column(children: [
      builDeleteButon(),
      Container(
          height: MediaQuery.of(currentContext).size.height * 0.8,
          child: GetBuilder<ControllerListCustomer>(
            builder: (ctl) {
              return ListView(
                children: customerLisst(),
              );
            },
          ))
    ]);
  }

  ControllerCheckBox controllerCheckBox = Get.put(ControllerCheckBox());
  deleteOnClick() {
    if (controllerCheckBox.markedCustomers.length > 0) {
      WidgetShowDialog.dialogAccept(
          'Xác Nhận Xóa ' +
              controllerCheckBox.markedCustomers.length.toString() +
              ' khách hàng', cancelTap: () {
        // controllerCheckBox.markedCustomers.clear();
        Navigator.pop(currentContext);
      }, acceptTap: () async {
        Navigator.pop(currentContext);
        WidgetShowDialog.showProcessBar(_controllerProcessBardelete);
        for (Customer element in controllerCheckBox.markedCustomers) {
          double percentProcess =
              (controllerCheckBox.markedCustomers.indexOf(element) + 1) /
                  controllerCheckBox.markedCustomers.length;
          bool result = await Customer.delete(element.id);
          await Future.delayed(Duration(milliseconds: 500));
          if (result == false) {
            _controllerProcessBardelete.seterror('Lỗi xóa ' + element.name);
          }
          _controllerProcessBardelete.changevalue(percentProcess);
        }
        controllerCheckBox.deleteAll();
        _controllerListCustomer.getAllCustomer();
        Navigator.pop(currentContext);
      });
    } else {
      WidgetShowDialog.dialogDetail(
          'Chưa chọn khách hàng nào', 'Hãy chọn khách hàng để xóa',
          cancelTap: () {});
    }
  }

  Widget builDeleteButon() {
    return GetBuilder<ControllerCheckBox>(
      builder: (builder) {
        return AnimatedContainer(
          duration: Duration(seconds: 1),
          height: controllerCheckBox.isShow
              ? MediaQuery.of(context).size.height * 0.1
              : 0,
          child: Center(
            child: IconButton(
              onPressed: deleteOnClick,
              icon: Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
