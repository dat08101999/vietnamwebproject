import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/controllers/oders_controller.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/screens/search_order_page.dart';
import 'package:flutter_back_end/widgets/widget_order.dart';
import 'package:get/get.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OdersPageState createState() => _OdersPageState();
}

class _OdersPageState extends State<OrdersPage> {
  OdersController _odersController;
  List<Order> orders;
  @override
  void initState() {
    super.initState();
    _odersController = Get.put(OdersController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Sách Đơn Hàng'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(() => SearchOrder(orders: this.orders));
              }),
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ctlScroll) {
              if (ctlScroll is ScrollEndNotification) if (ctlScroll
                      .metrics.pixels ==
                  ctlScroll.metrics.maxScrollExtent) {
                if (_odersController.limit < orders.length) {
                  _odersController.limit = 10;
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
    return GetBuilder<OdersController>(builder: (ctl) {
      return FutureBuilder(
          future: getOrders(limit: ctl.limit),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              orders = snapshot.data;
              return orders.length == 0
                  ? Center(
                      child: Text(
                      'Không có đơn hàng nào cả :((',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return WidgetOrder(order: orders[index]);
                      });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }

  Future<List<Order>> getOrders({int limit = 0}) async {
    // var token = await User.getToken();
    var paramas = {
      'token': ControllerMainPage.webToken,
      'limit': 10 + limit,
      'offset': 0
    };
    var response = await RequestDio.get(
        url: ConfigsMywebvietnam.getOders, parames: paramas);
    if (response['success']) {
      List _ordres = response['data'] ?? [];
      return List.generate(
          _ordres.length, (index) => Order.fromMap(_ordres[index]));
    } else {
      print('lấy dữ liệu lỗi');
      return null;
    }
  }
}
