import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_customers.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/customer.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/widgets/widget_customers.dart';
import 'package:get/get.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  ControllerCustomers _controllerCustomers = Get.put(ControllerCustomers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          alignment: Alignment.center,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ctlScroll) {
              if (ctlScroll is ScrollEndNotification) if (ctlScroll
                      .metrics.pixels ==
                  ctlScroll.metrics.maxScrollExtent) {
                if (_controllerCustomers.limit < 80) {
                  _controllerCustomers.limit = 10;
                }
                return true;
              }
              return false;
            },
            child: _buildBlogs(),
          )),
    );
  }

  Widget _buildBlogs() {
    return GetBuilder<ControllerCustomers>(builder: (ctl) {
      return FutureBuilder(
          future: getCustomer(limit: ctl.limit),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Customer> customers = snapshot.data;
              return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    if (index == customers.length) {
                      return Card(
                        child: ListTile(
                          leading: CircularProgressIndicator(),
                          title: Text(
                            'Đang tải ...',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    return WidgetCustomers(customer: customers[index]);
                  });
            } else {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }

  Future<List<Customer>> getCustomer({int limit = 0}) async {
    // var token = await User.getToken();
    var paramas = {
      'token': ControllerMainPage.webToken,
      'limit': 7 + limit,
      'offset': 0
    };
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getCustomers, parames: paramas);
    print(response);
    if (response['success']) {
      List orders = response['data'];
      return List.generate(
          orders.length, (index) => Customer.fromMap(orders[index]));
    } else {
      print('lấy dữ liệu lỗi');
      return null;
    }
  }
}
