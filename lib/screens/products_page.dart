import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/controllers/product_controller.dart';
import 'package:flutter_back_end/models/product.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/widgets/widget_product.dart';
import 'package:get/get.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductController _productController;
  @override
  void initState() {
    super.initState();
    _productController = Get.put(ProductController());
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
              if (_productController.limit < 80) {
                _productController.limit = 10;
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
  return GetBuilder<ProductController>(builder: (ctl) {
    return FutureBuilder(
        future: getOrders(limit: ctl.limit),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> _products = snapshot.data;
            return _products.length == 0
                ? Center(
                    child: Text(
                    'Không có sản phẩm nào cả :((',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ))
                : ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return WidgetProduct(product: _products[index]);
                    });
          } else {
            print(snapshot.error);
            return Center(child: CircularProgressIndicator());
          }
        });
  });
}

Future<List<Product>> getOrders({int limit = 0}) async {
  // var token = await User.getToken();
  var paramas = {
    'token': ControllerMainPage.webToken,
    'limit': 5 + limit,
    'offset': 0
  };
  var response = await RequestDio.get(
      url: ConfigsMywebvietnam.getProductsApi, parames: paramas);
  if (response['success']) {
    List _products = response['data'] ?? [];
    return List.generate(
        _products.length, (index) => Product.fromMap(_products[index]));
  } else {
    print('lấy dữ liệu lỗi');
    return null;
  }
}
