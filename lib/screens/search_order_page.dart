import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/order.dart';
import 'package:flutter_back_end/widgets/widget_order.dart';

class SearchOrder extends StatefulWidget {
  final List<Order> orders;

  const SearchOrder({Key key, this.orders}) : super(key: key);
  @override
  _SearchOrderState createState() => _SearchOrderState();
}

class _SearchOrderState extends State<SearchOrder> {
  final controllerSearch = TextEditingController();
  List<Order> _ordersSearched;

  @override
  void initState() {
    super.initState();
    controllerSearch.addListener(() {
      search();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white70,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: controllerSearch,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'nhập tên khách hàng tìm kiếm',
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: controllerSearch.text.isNotEmpty == true
                        ? _ordersSearched.length
                        : widget.orders.length,
                    itemBuilder: (context, index) => WidgetOrder(
                        order: controllerSearch.text.isNotEmpty == true
                            ? _ordersSearched[index]
                            : widget.orders[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search() {
    List<Order> _orders = [];
    _orders.addAll(widget.orders);
    if (controllerSearch.text.isNotEmpty) {
      _orders.retainWhere((element) {
        String searchText = controllerSearch.text.toLowerCase();
        String name = element.name.toLowerCase();
        return name.contains(searchText);
      });
    }
    setState(() {
      _ordersSearched = _orders;
    });
  }
}
