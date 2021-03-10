import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/controllers/controller_processbar.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/screens/customers_info_page.dart';
import 'package:flutter_back_end/widgets/widget_customers.dart';
import 'package:flutter_back_end/widgets/widget_showdialog.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _controllerListCustomer.getAllCustomer();
    return Scaffold(
      appBar: AppBar(
        actions: [buildbuttonAdd()],
        title: Text('Khách hàng'),
        centerTitle: true,
      ),
      body: Container(
          //color: Colors.grey,
          alignment: Alignment.center,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ctlScroll) {
              if (ctlScroll is ScrollEndNotification) if (ctlScroll
                      .metrics.pixels ==
                  ctlScroll.metrics.maxScrollExtent) {
                if (controllerCustomers.limit <
                    _controllerListCustomer.customers.length) {
                  controllerCustomers.limit = 10;
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
    _controllerListCustomer.getAllCustomer();
    return Column(children: [
      builDeleteButon(),
      Expanded(child: GetBuilder<ControllerListCustomer>(
        builder: (ctl) {
          if (ctl.customers.length > 0)
            return ListView(
              children: customerLisst(),
            );
          return Center(
            child: Text('Opps ! Có lỗi gì đó !'),
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
        Navigator.pop(currentContext);
      }, acceptTap: () async {
        Navigator.pop(currentContext);
        WidgetShowDialog.showProcessBar(_controllerProcessBardelete);
        for (int i = 0; i < controllerCheckBox.markedCustomers.length; i++) {
          print(i);
          double percentProcess =
              (i + 1) / controllerCheckBox.markedCustomers.length;
          bool result =
              await Customer.delete(controllerCheckBox.markedCustomers[i].id);
          if (result == false) {
            _controllerProcessBardelete.seterror(
                ' Lỗi xóa ' + controllerCheckBox.markedCustomers[i].name);
          }
          await Future.delayed(Duration(milliseconds: 100));
          _controllerProcessBardelete.changevalue(percentProcess);
        }
        controllerCheckBox.deleteAll();
        _controllerListCustomer.getAllCustomer();
        Navigator.pop(currentContext);
      });
    } else {
      WidgetShowDialog.dialogDetail(
          'Chưa chọn khách hàng nào', 'Hãy chọn khách hàng để xóa',
          cancelTap: () {
        Navigator.pop(currentContext);
      });
    }
  }

  Widget builDeleteButon() {
    return GetBuilder<ControllerCheckBox>(
      builder: (builder) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: controllerCheckBox.isShow
              ? MediaQuery.of(context).size.height * 0.05
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
