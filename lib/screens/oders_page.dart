import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/configs/config_theme.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/controllers/oders_controller.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/screens/search_order_page.dart';
import 'package:flutter_back_end/widgets/widget_order.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

AsyncMemoizer<List<Order>> _cacheOrders = AsyncMemoizer();

class OrdersPage extends StatefulWidget {
  @override
  _OdersPageState createState() => _OdersPageState();
}

class _OdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  OrdersController _ordersController;
  List<Order> _orders;
  List<Order> _ordersStatus0 = [];

  @override
  void initState() {
    super.initState();
    _ordersController = Get.put(OrdersController());
    Get.find<ControllerMainPage>().getInforMation();
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn Hàng'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(() => SearchOrder(orders: _orders));
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
                if (_ordersController.limit < _orders.length) {
                  _cacheOrders = new AsyncMemoizer();
                  if (_tabController.index == 1) _ordersStatus0.clear();
                  _ordersController.limit = 10;
                }
                return true;
              }
              return false;
            },
            child: _buildOrders(),
          )),
    );
  }

  Widget _buildOrders() {
    return GetBuilder<OrdersController>(builder: (ctl) {
      return FutureBuilder(
          future: getOrders(limit: ctl.limit),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _orders = snapshot.data;
              return _orders.length == 0
                  ? Center(
                      child: Text(
                      'Không có đơn hàng nào cả :((',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ))
                  : main();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }

  Widget main() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5.0,
              ),
              color: ConfigTheme.primaryColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: ConfigTheme.primaryColor,
            controller: _tabController,
            tabs: [
              Tab(
                  child: Text(
                'Tất Cả',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Tab(
                  child: Text(
                'Chờ Duyệt',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Tab(
                  child: Text(
                'Đã Thanh Toán',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
              Tab(
                  child: Text(
                'Chưa Thanh Toán',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              //* Tất cả
              RefreshIndicator(
                onRefresh: () async {
                  _cacheOrders = new AsyncMemoizer();
                  _ordersController.update();
                },
                child: ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      return _buildItem(
                          WidgetOrder(order: _orders[index]), _orders[index]);
                    }),
              ),
              //* Đang Chờ Duyệt
              RefreshIndicator(
                onRefresh: () async {
                  _cacheOrders = new AsyncMemoizer();
                  _ordersController.update();
                  _ordersStatus0.clear();
                },
                child: ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      if ((_orders[index].status is int
                              ? _orders[index].status
                              : int.parse(_orders[index].status)) ==
                          0) {
                        if (_ordersStatus0.indexWhere(
                                (element) => element.id == _orders[index].id) ==
                            -1) _ordersStatus0.add(_orders[index]);
                        return _buildItem(
                            WidgetOrder(order: _orders[index]), _orders[index]);
                      } else {
                        return Container();
                      }
                    }),
              ),
              //* Đã Thanh Toán
              RefreshIndicator(
                onRefresh: () async {
                  _cacheOrders = new AsyncMemoizer();
                  _ordersController.update();
                },
                child: ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      if (_orders[index].timeline['purchased'] > 1) {
                        return _buildItem(
                            WidgetOrder(order: _orders[index]), _orders[index]);
                      } else {
                        return Container();
                      }
                    }),
              ),
              //* Chưa thanh toán
              RefreshIndicator(
                onRefresh: () async {
                  _cacheOrders = new AsyncMemoizer();
                  _ordersController.update();
                },
                child: ListView.builder(
                    itemCount: _orders.length,
                    itemBuilder: (context, index) {
                      if (_orders[index].timeline['purchased'] == 0) {
                        return _buildItem(
                            WidgetOrder(order: _orders[index]), _orders[index]);
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<Order>> getOrders({int limit = 0}) async {
    return _cacheOrders.runOnce(() async {
      var paramas = {
        'token': ControllerMainPage.webToken,
        'limit': 10 + limit,
        'offset': 0
      };
      var response = await RequestDio.get(
          url: ConfigsMywebvietnam.getOrders, parames: paramas);
      if (response['success']) {
        List _ordres = response['data'] ?? [];
        return List.generate(
            _ordres.length, (index) => Order.fromMap(_ordres[index]));
      } else {
        print('lấy dữ liệu lỗi');
        return null;
      }
    });
  }

  Widget _buildItem(
    Widget child,
    dynamic item,
  ) =>
      Slidable(
        child: child,
        showAllActionsThreshold: 1,
        secondaryActions: [
          IconSlideAction(
              caption: 'Xóa',
              color: Colors.red[400],
              icon: Icons.delete,
              onTap: () async {
                var delete = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Xác Nhận'),
                    content: Text('Sản phẩm này sẽ bị xóa ?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('Đồng Ý')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('Hủy Bỏ')),
                    ],
                  ),
                );
                if (delete) {
                  var deleted = await Order.deleteOrders(item);
                  if (deleted) {
                    _cacheOrders.future.then((list) => list.remove(item));
                    _ordersController.update();
                  }
                }
              })
        ],
        actionPane: SlidableDrawerActionPane(),
      );
}
