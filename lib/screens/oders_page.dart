import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/oders_controller.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/widgets/widget_order.dart';
import 'package:get/get.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OdersPageState createState() => _OdersPageState();
}

class _OdersPageState extends State<OrdersPage> {
  OdersController _odersController;
  @override
  void initState() {
    super.initState();
    _odersController = Get.put(OdersController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ctlScroll) {
            if (ctlScroll is ScrollEndNotification) if (ctlScroll
                    .metrics.pixels ==
                ctlScroll.metrics.maxScrollExtent) {
              if (_odersController.limit < 80) {
                _odersController.limit = 10;
              }
              return true;
            }
            return false;
          },
          child: _buildBlogs(),
        ));
  }
}

Widget _buildBlogs() {
  return GetBuilder<OdersController>(builder: (ctl) {
    return FutureBuilder(
        future: getBlogs(limit: ctl.limit),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order> orders = snapshot.data;
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    return Card(
                      child: ListTile(
                        leading: CircularProgressIndicator(),
                        title: Text(
                          'Đang tải ...',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  return WidgetOrder(order: orders[index]);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  });
}

Future<List<Order>> getBlogs({int limit = 0}) async {
  // var token = await User.getToken();
  var paramas = {
    'token': '4779ce0e8eeb2de09fd04dd38c7d0526',
    'limit': 7 + limit,
    'offset': 0
  };
  var response =
      await RequestDio.get(url: ConfigsMywebvietnam.getOders, parames: paramas);
  if (response['success']) {
    List orders = response['data'];
    return List.generate(
        orders.length, (index) => Order.fromMap(orders[index]));
  } else {
    print('lấy dữ liệu lỗi');
    return null;
  }
}
